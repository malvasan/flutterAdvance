import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:wisy_mobile_challenge/src/domain/retrieve_images/image_firebase.dart';
import 'package:wisy_mobile_challenge/src/domain/upload_images/image_metadata.dart';

class FirebaseRepositorie {
  static Stream<List<ImageFirebase>> retrieveImages() {
    final stream = FirebaseFirestore.instance
        .collection('images')
        .orderBy('timestamp')
        .snapshots();
    return stream.map((snapshot) => snapshot.docs
        .map((doc) => ImageFirebase.fromJson(doc.data()))
        .toList());
  }

  static Future<String> uploadImage(String filePath) async {
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

  static void uploadImageMetadata(ImageMetadata image) {
    CollectionReference collRef =
        FirebaseFirestore.instance.collection('images');
    collRef.add(image.toJson());
  }
}
