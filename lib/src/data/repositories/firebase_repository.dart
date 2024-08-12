import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:wisy_mobile_challenge/src/domain/retrieve_images/image_firebase.dart';
import 'package:wisy_mobile_challenge/src/domain/upload_images/image_metadata.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'firebase_repository.g.dart';

class FirebaseRepository {
  FirebaseRepository(this.instance);
  final FirebaseFirestore instance;

  Stream<List<ImageFirebase>> retrieveImages() {
    final stream =
        instance.collection('images').orderBy('timestamp').snapshots();
    return stream.map((snapshot) => snapshot.docs
        .map((doc) => ImageFirebase.fromJson(doc.data()))
        .toList());
  }

  Future<String> uploadImage(String filePath) async {
    Reference referenceRoot = FirebaseStorage.instance.ref();
    Reference referenceDirImages = referenceRoot.child('images');

    Reference referenceImageUploaded =
        referenceDirImages.child(filePath.split('test/')[1]);
    try {
      if (File(filePath).existsSync()) {
        await referenceImageUploaded.putFile(File(filePath));
        return await referenceImageUploaded.getDownloadURL();
      } else {
        throw Exception("Error: Image do not exist in file system");
      }
    } catch (e) {
      throw Exception("Error: Image not uploaded");
    }
  }

  void addImage(ImageMetadata image) async {
    CollectionReference collRef = instance.collection('images');
    await collRef.add(image.toJson());
  }

  void setImage(ImageMetadata image, String docId) async {
    CollectionReference collRef = instance.collection('images');
    await collRef.doc(docId).set(image.toJson());
  }
}

@riverpod
FirebaseRepository firebaseRepository(FirebaseRepositoryRef ref) {
  return FirebaseRepository(FirebaseFirestore.instance);
}
