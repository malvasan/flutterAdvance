import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:wisy_mobile_challenge/src/exception/storage_exception.dart';

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
        throw StorageException(
          type: StorageExceptionType.imageNotLocalStorage,
          message: 'Image do not exist in file system.',
        );
      }
    } catch (e) {
      throw StorageException(
        type: StorageExceptionType.imageNotUplodaded,
        message: 'Image not uploaded.',
        error: e,
      );
    }
  }
}

@Riverpod(keepAlive: true)
StorageRepository storageRepository(StorageRepositoryRef ref) {
  return StorageRepository(FirebaseStorage.instance);
}
