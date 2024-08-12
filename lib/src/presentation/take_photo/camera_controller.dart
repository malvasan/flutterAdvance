import 'dart:io';

import 'package:exif/exif.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:wisy_mobile_challenge/src/data/repositories/firebase_repository.dart';
import 'package:wisy_mobile_challenge/src/domain/upload_images/image_metadata.dart';

part 'camera_controller.g.dart';

@riverpod
CameraController cameraController(CameraControllerRef ref) {
  return CameraController(ref);
}

class CameraController {
  const CameraController(this.ref);
  final Ref ref;
  Future<void> uploadImage(String filePath) async {
    final firebaseInstance = ref.read(firebaseRepositoryProvider);
    final imageURL = await firebaseInstance.uploadImage(filePath);

    final fileBytes = File(filePath).readAsBytesSync();
    final rawData = await readExifFromBytes(fileBytes);
    if (rawData.isNotEmpty) {
      var data = rawData.map((key, value) => MapEntry(key, value.printable));
      data['url'] = imageURL;
      data['orientation'] = data['Image Orientation'] as String;
      data['timestamp'] = data['Image DateTime'] as String;
      data['latitude'] = data['GPS GPSLatitude'] as String;
      data['longitude'] = data['GPS GPSLongitude'] as String;

      final imageMetadata = ImageMetadata.fromJson(data);

      firebaseInstance.addImage(imageMetadata);
    }
  }
}
