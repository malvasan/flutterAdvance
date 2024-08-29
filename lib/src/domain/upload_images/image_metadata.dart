import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:wisy_mobile_challenge/src/utils/utils.dart';

part 'image_metadata.freezed.dart';
part 'image_metadata.g.dart';

class UrlSerializer implements JsonConverter<String?, dynamic> {
  const UrlSerializer();

  @override
  String? fromJson(dynamic url) {
    final imageURL = url as String;
    return imageURL.substring(0, 4) != 'Error' ? imageURL : null;
  }

  @override
  String? toJson(String? url) => url;
}

class OrientationSerializer implements JsonConverter<String?, dynamic> {
  const OrientationSerializer();

  @override
  String? fromJson(dynamic orientation) {
    return normalizeOrientation(orientation as String? ?? '');
  }

  @override
  String? toJson(String? orientation) => orientation;
}

class TimeSerializer implements JsonConverter<DateTime, dynamic> {
  const TimeSerializer();

  @override
  DateTime fromJson(dynamic timestamp) {
    return convertStringToDateTime(
        timestamp as String? ?? '2000:00:00 00:00:00');
  }

  @override
  DateTime toJson(DateTime timestamp) => timestamp;
}

@freezed
class ImageMetadata with _$ImageMetadata {
  const factory ImageMetadata(
      {@UrlSerializer() required String? url,
      @OrientationSerializer() required String? orientation,
      @TimeSerializer() required DateTime timestamp,
      required String? latitude,
      required String? longitude}) = _ImageMetadata;

  factory ImageMetadata.fromJson(Map<String, Object?> json) =>
      _$ImageMetadataFromJson(json);
}
