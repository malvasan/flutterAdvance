import 'package:exif/exif.dart';

DateTime convertStringToDateTime(String date) {
  date = date.replaceFirst(' ', 'T');
  date = date.replaceAll(':', '');
  return DateTime.parse(date).toLocal();
}

String normalizeOrientation(String orientation) {
  final orientationHorizontal = ['Horizontal (normal)', 'Rotated 180'];
  final orientationVertical = ['Rotated 90 CCW', 'Rotated 90 CW'];
  if (orientationHorizontal.contains(orientation)) {
    return 'Horizontal';
  } else if (orientationVertical.contains(orientation)) {
    return 'Vertical';
  } else {
    return '';
  }
}

Map<String, String?> normalizeRawData(
    Map<String, IfdTag> rawData, String imageURL) {
  var data = <String, String?>{};
  data['url'] = imageURL;
  data['orientation'] = rawData['Image Orientation']?.printable;
  data['timestamp'] = rawData['Image DateTime']?.printable;
  data['latitude'] = rawData['GPS GPSLatitude']?.printable;
  data['longitude'] = rawData['GPS GPSLongitude']?.printable;
  return data;
}
