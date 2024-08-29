import 'dart:developer';
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
    log('retrieve images');
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

  Future<String> addImage(ImageMetadata image) async {
    CollectionReference collRef = instance.collection('images');
    final doc = await collRef.add(image.toJson());
    return doc.id;
  }

  Future<void> setImage(ImageMetadata image, String docId) async {
    CollectionReference collRef = instance.collection('images');
    await collRef.doc(docId).set(image.toJson());
  }
}

@Riverpod(keepAlive: true)
FirebaseRepository firebaseRepository(FirebaseRepositoryRef ref) {
  log('build: firebaseRepository');
  ref.onDispose(() => log('dispose: firebaseRepository'));
  ref.onCancel(() => log('cancel: firebaseRepository'));
  ref.onResume(() => log('resume: firebaseRepository'));
  ref.onAddListener(() => log('add listener: firebaseRepository'));
  ref.onRemoveListener(() => log('remove listener: firebaseRepository'));
  return FirebaseRepository(FirebaseFirestore.instance);
}
