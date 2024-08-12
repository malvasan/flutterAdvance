import 'dart:io';

import 'package:exif/exif.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:wisy_mobile_challenge/src/data/repositories/firebase_repositorie.dart';
import 'package:wisy_mobile_challenge/src/domain/upload_images/image_metadata.dart';

part 'camera_controller.g.dart';

@riverpod
CameraController cameraController(CameraControllerRef ref) {
  return CameraController();
}

class CameraController {
  Future<void> uploadImage(String filePath) async {
    final imageURL = await FirebaseRepositorie.uploadImage(filePath);

    final fileBytes = File(filePath).readAsBytesSync();
    final rawData = await readExifFromBytes(fileBytes);
    if (rawData.isNotEmpty) {
      var data = rawData.map((key, value) => MapEntry(key, value.printable));
      data['imageURL'] = imageURL;
      final imageMetadata = ImageMetadata.fromJson(data);

      FirebaseRepositorie.uploadImageMetadata(imageMetadata);
    }
  }
}
