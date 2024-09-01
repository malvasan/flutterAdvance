import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'storage_repository.g.dart';

class StorageRepository {
  StorageRepository(this.instance);
  final FirebaseStorage instance;

  Future<String> uploadImage(String filePath) async {
    final referenceDirImages = instance.ref().child('images');

    final referenceImageUploaded =
        referenceDirImages.child(filePath.split('test/')[1]);
    try {
      if (File(filePath).existsSync()) {
        await referenceImageUploaded.putFile(File(filePath));
        return referenceImageUploaded.getDownloadURL();
      } else {
        throw Exception("Error: Image do not exist in file system");
      }
    } catch (e) {
      throw Exception("Error: Image not uploaded");
    }
  }
}

@Riverpod(keepAlive: true)
StorageRepository storageRepository(StorageRepositoryRef ref) {
  return StorageRepository(FirebaseStorage.instance);
}
