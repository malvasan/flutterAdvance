import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';

part 'image_firebase.freezed.dart';
part 'image_firebase.g.dart';

// class ImageFirebase {
//   ImageFirebase(
//       {required this.url,
//       required this.orientation,
//       required this.timestamp,
//       required this.latitude,
//       required this.longitude});
//   final String? url;
//   final String? orientation;
//   final Timestamp timestamp;
//   final String? latitude;
//   final String? longitude;

//   factory ImageFirebase.json(Map<String, dynamic> json) {
//     return ImageFirebase(
//         url: json['url'],
//         orientation: json['orientation'],
//         timestamp: json['timestamp'],
//         latitude: json['latitude'],
//         longitude: json['longitude']);
//   }
// }

class TimestampSerializer implements JsonConverter<DateTime, dynamic> {
  const TimestampSerializer();

  @override
  DateTime fromJson(dynamic timestamp) => timestamp.toDate();

  @override
  Timestamp toJson(DateTime date) => Timestamp.fromDate(date);
}

@freezed
class ImageFirebase with _$ImageFirebase {
  const factory ImageFirebase(
      {required String? url,
      required String? orientation,
      @TimestampSerializer() required DateTime timestamp,
      required String? latitude,
      required String? longitude}) = _ImageFirebase;

  factory ImageFirebase.fromJson(Map<String, Object?> json) =>
      _$ImageFirebaseFromJson(json);
}
