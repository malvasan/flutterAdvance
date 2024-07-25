import 'dart:io';

import 'package:camerawesome/camerawesome_plugin.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:exif/exif.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:path_provider/path_provider.dart';

final cameraControllerProvider = Provider<CameraController>((ref) {
  return CameraController();
});

class CameraController {
  Future<void> uploadImage(String filePath) async {
    Reference referenceRoot = FirebaseStorage.instance.ref();
    Reference referenceDirImages = referenceRoot.child('images');

    Reference referenceImageUploaded =
        referenceDirImages.child(filePath.split('test/')[1]);
    try {
      if (File(filePath).existsSync()) {
        await referenceImageUploaded.putFile(File(filePath));
        final imageURL = await referenceImageUploaded.getDownloadURL();

        final fileBytes = File(filePath).readAsBytesSync();
        final data = await readExifFromBytes(fileBytes);
        if (data.isNotEmpty) {
          final imageMetadata = <String, dynamic>{
            'url': imageURL,
            'orientation': normalizeOrientation(
                data['Image Orientation']?.printable ?? ''),
            'timestamp': convertStringToDateTime(
                data['Image DateTime']?.printable ?? '2000:00:00 00:00:00'),
            'latitude': data['GPS GPSLatitude']?.printable,
            'longitude': data['GPS GPSLongitude']?.printable,
          };
          CollectionReference collRef =
              FirebaseFirestore.instance.collection('images');
          collRef.add(imageMetadata);
        }
      }
    } catch (error) {
      print(error);
    }
  }

  DateTime convertStringToDateTime(String date) {
    date = date.replaceFirst(' ', 'T');
    date = date.replaceAll(':', '');
    return DateTime.parse(date).toLocal();
  }

  String normalizeOrientation(String orientation) {
    final orientationHorizontal = ['Horizontal(normal)', 'Rotated 180'];
    final orientationVertical = ['Rotated 90 CCW', 'Rotated 90 CW'];
    if (orientationHorizontal.contains(orientation)) {
      return 'Horizontal';
    } else if (orientationVertical.contains(orientation)) {
      return 'Vertical';
    } else {
      return '';
    }
  }

  Future<String> path(CaptureMode captureMode) async {
    final Directory extDir = await getTemporaryDirectory();
    final testDir =
        await Directory('${extDir.path}/test').create(recursive: true);
    final String fileExtension =
        captureMode == CaptureMode.photo ? 'jpg' : 'mp4';
    final String filePath =
        '${testDir.path}/${DateTime.now().millisecondsSinceEpoch}.$fileExtension';
    return filePath;
  }
}
