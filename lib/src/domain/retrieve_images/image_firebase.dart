import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';

part 'image_firebase.freezed.dart';
part 'image_firebase.g.dart';

class TimestampSerializer implements JsonConverter<DateTime, dynamic> {
  const TimestampSerializer();

  @override
  DateTime fromJson(dynamic timestamp) => timestamp.toDate();

  @override
  Timestamp toJson(DateTime date) => Timestamp.fromDate(date);
}

@freezed
class ImageFirebase with _$ImageFirebase {
  const factory ImageFirebase({
    required String? url,
    required String? orientation,
    @TimestampSerializer() required DateTime timestamp,
    required String? latitude,
    required String? longitude,
  }) = _ImageFirebase;

  factory ImageFirebase.fromJson(Map<String, Object?> json) =>
      _$ImageFirebaseFromJson(json);
}
