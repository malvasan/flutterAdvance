// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'image_firebase.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

ImageFirebase _$ImageFirebaseFromJson(Map<String, dynamic> json) {
  return _ImageFirebase.fromJson(json);
}

/// @nodoc
mixin _$ImageFirebase {
  String? get url => throw _privateConstructorUsedError;
  String? get orientation => throw _privateConstructorUsedError;
  @TimestampSerializer()
  DateTime get timestamp => throw _privateConstructorUsedError;
  String? get latitude => throw _privateConstructorUsedError;
  String? get longitude => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ImageFirebaseCopyWith<ImageFirebase> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ImageFirebaseCopyWith<$Res> {
  factory $ImageFirebaseCopyWith(
          ImageFirebase value, $Res Function(ImageFirebase) then) =
      _$ImageFirebaseCopyWithImpl<$Res, ImageFirebase>;
  @useResult
  $Res call(
      {String? url,
      String? orientation,
      @TimestampSerializer() DateTime timestamp,
      String? latitude,
      String? longitude});
}

/// @nodoc
class _$ImageFirebaseCopyWithImpl<$Res, $Val extends ImageFirebase>
    implements $ImageFirebaseCopyWith<$Res> {
  _$ImageFirebaseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? url = freezed,
    Object? orientation = freezed,
    Object? timestamp = null,
    Object? latitude = freezed,
    Object? longitude = freezed,
  }) {
    return _then(_value.copyWith(
      url: freezed == url
          ? _value.url
          : url // ignore: cast_nullable_to_non_nullable
              as String?,
      orientation: freezed == orientation
          ? _value.orientation
          : orientation // ignore: cast_nullable_to_non_nullable
              as String?,
      timestamp: null == timestamp
          ? _value.timestamp
          : timestamp // ignore: cast_nullable_to_non_nullable
              as DateTime,
      latitude: freezed == latitude
          ? _value.latitude
          : latitude // ignore: cast_nullable_to_non_nullable
              as String?,
      longitude: freezed == longitude
          ? _value.longitude
          : longitude // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ImageFirebaseImplCopyWith<$Res>
    implements $ImageFirebaseCopyWith<$Res> {
  factory _$$ImageFirebaseImplCopyWith(
          _$ImageFirebaseImpl value, $Res Function(_$ImageFirebaseImpl) then) =
      __$$ImageFirebaseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String? url,
      String? orientation,
      @TimestampSerializer() DateTime timestamp,
      String? latitude,
      String? longitude});
}

/// @nodoc
class __$$ImageFirebaseImplCopyWithImpl<$Res>
    extends _$ImageFirebaseCopyWithImpl<$Res, _$ImageFirebaseImpl>
    implements _$$ImageFirebaseImplCopyWith<$Res> {
  __$$ImageFirebaseImplCopyWithImpl(
      _$ImageFirebaseImpl _value, $Res Function(_$ImageFirebaseImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? url = freezed,
    Object? orientation = freezed,
    Object? timestamp = null,
    Object? latitude = freezed,
    Object? longitude = freezed,
  }) {
    return _then(_$ImageFirebaseImpl(
      url: freezed == url
          ? _value.url
          : url // ignore: cast_nullable_to_non_nullable
              as String?,
      orientation: freezed == orientation
          ? _value.orientation
          : orientation // ignore: cast_nullable_to_non_nullable
              as String?,
      timestamp: null == timestamp
          ? _value.timestamp
          : timestamp // ignore: cast_nullable_to_non_nullable
              as DateTime,
      latitude: freezed == latitude
          ? _value.latitude
          : latitude // ignore: cast_nullable_to_non_nullable
              as String?,
      longitude: freezed == longitude
          ? _value.longitude
          : longitude // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ImageFirebaseImpl
    with DiagnosticableTreeMixin
    implements _ImageFirebase {
  const _$ImageFirebaseImpl(
      {required this.url,
      required this.orientation,
      @TimestampSerializer() required this.timestamp,
      required this.latitude,
      required this.longitude});

  factory _$ImageFirebaseImpl.fromJson(Map<String, dynamic> json) =>
      _$$ImageFirebaseImplFromJson(json);

  @override
  final String? url;
  @override
  final String? orientation;
  @override
  @TimestampSerializer()
  final DateTime timestamp;
  @override
  final String? latitude;
  @override
  final String? longitude;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'ImageFirebase(url: $url, orientation: $orientation, timestamp: $timestamp, latitude: $latitude, longitude: $longitude)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'ImageFirebase'))
      ..add(DiagnosticsProperty('url', url))
      ..add(DiagnosticsProperty('orientation', orientation))
      ..add(DiagnosticsProperty('timestamp', timestamp))
      ..add(DiagnosticsProperty('latitude', latitude))
      ..add(DiagnosticsProperty('longitude', longitude));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ImageFirebaseImpl &&
            (identical(other.url, url) || other.url == url) &&
            (identical(other.orientation, orientation) ||
                other.orientation == orientation) &&
            (identical(other.timestamp, timestamp) ||
                other.timestamp == timestamp) &&
            (identical(other.latitude, latitude) ||
                other.latitude == latitude) &&
            (identical(other.longitude, longitude) ||
                other.longitude == longitude));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType, url, orientation, timestamp, latitude, longitude);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ImageFirebaseImplCopyWith<_$ImageFirebaseImpl> get copyWith =>
      __$$ImageFirebaseImplCopyWithImpl<_$ImageFirebaseImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ImageFirebaseImplToJson(
      this,
    );
  }
}

abstract class _ImageFirebase implements ImageFirebase {
  const factory _ImageFirebase(
      {required final String? url,
      required final String? orientation,
      @TimestampSerializer() required final DateTime timestamp,
      required final String? latitude,
      required final String? longitude}) = _$ImageFirebaseImpl;

  factory _ImageFirebase.fromJson(Map<String, dynamic> json) =
      _$ImageFirebaseImpl.fromJson;

  @override
  String? get url;
  @override
  String? get orientation;
  @override
  @TimestampSerializer()
  DateTime get timestamp;
  @override
  String? get latitude;
  @override
  String? get longitude;
  @override
  @JsonKey(ignore: true)
  _$$ImageFirebaseImplCopyWith<_$ImageFirebaseImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
