import 'dart:developer';
import 'dart:io';

import 'package:exif/exif.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:wisy_mobile_challenge/src/data/repositories/data_base_repository.dart';
import 'package:wisy_mobile_challenge/src/data/repositories/storage_repository.dart';
import 'package:wisy_mobile_challenge/src/domain/upload_images/image_metadata.dart';
import 'package:wisy_mobile_challenge/src/utils/utils.dart';

part 'camera_controller.g.dart';

@riverpod
class CameraController extends _$CameraController {
  @override
  FutureOr<String> build() {
    return '';
  }

  Future<void> uploadImage(String filePath) async {
    state = const AsyncLoading();

    state = await AsyncValue.guard(() async {
      final imageURL =
          await ref.read(storageRepositoryProvider).uploadImage(filePath);
      final fileBytes = File(filePath).readAsBytesSync();

      final rawData = await readExifFromBytes(fileBytes);

      if (rawData.isNotEmpty) {
        var data = normalizeRawData(rawData, imageURL);

        final imageMetadata = ImageMetadata.fromJson(data);

        final docId =
            await ref.read(dataBaseRepositoryProvider).addImage(imageMetadata);

        return docId;
      }
      throw Exception();
    });
  }
}
