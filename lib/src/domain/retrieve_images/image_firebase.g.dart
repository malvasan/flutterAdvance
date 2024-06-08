// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'image_firebase.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ImageFirebaseImpl _$$ImageFirebaseImplFromJson(Map<String, dynamic> json) =>
    _$ImageFirebaseImpl(
      url: json['url'] as String?,
      orientation: json['orientation'] as String?,
      timestamp: const TimestampSerializer().fromJson(json['timestamp']),
      latitude: json['latitude'] as String?,
      longitude: json['longitude'] as String?,
    );

Map<String, dynamic> _$$ImageFirebaseImplToJson(_$ImageFirebaseImpl instance) =>
    <String, dynamic>{
      'url': instance.url,
      'orientation': instance.orientation,
      'timestamp': const TimestampSerializer().toJson(instance.timestamp),
      'latitude': instance.latitude,
      'longitude': instance.longitude,
    };
