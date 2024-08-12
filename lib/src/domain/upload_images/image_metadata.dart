import 'package:wisy_mobile_challenge/src/utils/camera_utils.dart';

class ImageMetadata {
  ImageMetadata(
      {required this.url,
      required this.orientation,
      required this.timestamp,
      required this.latitude,
      required this.longitude});
  final String? url;
  final String? orientation;
  final DateTime? timestamp;
  final String? latitude;
  final String? longitude;

  factory ImageMetadata.fromJson(Map<String, Object?> json) {
    final imageURL = json['imageURL'] as String;
    return ImageMetadata(
      url: imageURL.substring(0, 4) != 'Error' ? imageURL : null,
      orientation:
          normalizeOrientation(json['Image Orientation'] as String? ?? ''),
      timestamp: convertStringToDateTime(
          json['Image DateTime'] as String? ?? '2000:00:00 00:00:00'),
      latitude: json['GPS GPSLatitude'] as String?,
      longitude: json['GPS GPSLongitude'] as String?,
    );
  }

  Map<String, Object?> toJson() {
    return {
      'url': url,
      'orientation': orientation,
      'timestamp': timestamp,
      'latitude': latitude,
      'longitude': longitude,
    };
  }
}
