import 'dart:io';

import 'package:camerawesome/camerawesome_plugin.dart';
import 'package:path_provider/path_provider.dart';

Future<String> path(CaptureMode captureMode) async {
  final Directory extDir = await getTemporaryDirectory();
  final testDir =
      await Directory('${extDir.path}/test').create(recursive: true);
  final String fileExtension = captureMode == CaptureMode.photo ? 'jpg' : 'mp4';
  final String filePath =
      '${testDir.path}/${DateTime.now().millisecondsSinceEpoch}.$fileExtension';
  return filePath;
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
