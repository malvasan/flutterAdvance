// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'image_metadata.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ImageMetadataImpl _$$ImageMetadataImplFromJson(Map<String, dynamic> json) =>
    _$ImageMetadataImpl(
      url: const UrlSerializer().fromJson(json['url']),
      orientation: const OrientationSerializer().fromJson(json['orientation']),
      timestamp: const TimeSerializer().fromJson(json['timestamp']),
      latitude: json['latitude'] as String?,
      longitude: json['longitude'] as String?,
    );

Map<String, dynamic> _$$ImageMetadataImplToJson(_$ImageMetadataImpl instance) =>
    <String, dynamic>{
      'url': const UrlSerializer().toJson(instance.url),
      'orientation': const OrientationSerializer().toJson(instance.orientation),
      'timestamp': const TimeSerializer().toJson(instance.timestamp),
      'latitude': instance.latitude,
      'longitude': instance.longitude,
    };
