import 'dart:developer';
import 'dart:io';

import 'package:exif/exif.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:wisy_mobile_challenge/src/data/repositories/firebase_repository.dart';
import 'package:wisy_mobile_challenge/src/domain/upload_images/image_metadata.dart';
import 'package:wisy_mobile_challenge/src/utils/utils.dart';

part 'camera_controller.g.dart';

@riverpod
class CameraController extends _$CameraController {
  @override
  FutureOr<String> build() {
    log('build: CameraController');
    ref.onDispose(() => log('dispose: CameraController'));
    ref.onCancel(() => log('cancel: CameraController'));
    ref.onResume(() => log('resume: CameraController'));
    ref.onAddListener(() => log('add listener: CameraController'));
    ref.onRemoveListener(() => log('remove listener: CameraController'));
    return '';
  }

  Future<void> uploadImage(String filePath) async {
    final firebaseInstance = ref.read(firebaseRepositoryProvider);

    state = const AsyncLoading();

    state = await AsyncValue.guard(() async {
      final imageURL = await firebaseInstance.uploadImage(filePath);
      final fileBytes = File(filePath).readAsBytesSync();

      final rawData = await readExifFromBytes(fileBytes);

      if (rawData.isNotEmpty) {
        var data = normalizeRawData(rawData, imageURL);

        final imageMetadata = ImageMetadata.fromJson(data);

        final docId = await firebaseInstance.addImage(imageMetadata);
        // log('image uploaded: ');
        return docId;
      }
      throw Exception();
    });
  }
}
