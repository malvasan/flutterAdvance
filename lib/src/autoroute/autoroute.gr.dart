// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i5;
import 'package:wisy_mobile_challenge/src/presentation/authentication/sign_in.dart'
    as _i3;
import 'package:wisy_mobile_challenge/src/presentation/authentication/sign_up.dart'
    as _i4;
import 'package:wisy_mobile_challenge/src/presentation/retrieve_images/images_list.dart'
    as _i2;
import 'package:wisy_mobile_challenge/src/presentation/take_photo/camera.dart'
    as _i1;

/// generated route for
/// [_i1.CameraPage]
class CameraRoute extends _i5.PageRouteInfo<void> {
  const CameraRoute({List<_i5.PageRouteInfo>? children})
      : super(
          CameraRoute.name,
          initialChildren: children,
        );

  static const String name = 'CameraRoute';

  static _i5.PageInfo page = _i5.PageInfo(
    name,
    builder: (data) {
      return const _i1.CameraPage();
    },
  );
}

/// generated route for
/// [_i2.ImagesPresentationPage]
class ImagesPresentationRoute extends _i5.PageRouteInfo<void> {
  const ImagesPresentationRoute({List<_i5.PageRouteInfo>? children})
      : super(
          ImagesPresentationRoute.name,
          initialChildren: children,
        );

  static const String name = 'ImagesPresentationRoute';

  static _i5.PageInfo page = _i5.PageInfo(
    name,
    builder: (data) {
      return const _i2.ImagesPresentationPage();
    },
  );
}

/// generated route for
/// [_i3.LoginPage]
class LoginRoute extends _i5.PageRouteInfo<void> {
  const LoginRoute({List<_i5.PageRouteInfo>? children})
      : super(
          LoginRoute.name,
          initialChildren: children,
        );

  static const String name = 'LoginRoute';

  static _i5.PageInfo page = _i5.PageInfo(
    name,
    builder: (data) {
      return const _i3.LoginPage();
    },
  );
}

/// generated route for
/// [_i2.RootPage]
class RootRoute extends _i5.PageRouteInfo<void> {
  const RootRoute({List<_i5.PageRouteInfo>? children})
      : super(
          RootRoute.name,
          initialChildren: children,
        );

  static const String name = 'RootRoute';

  static _i5.PageInfo page = _i5.PageInfo(
    name,
    builder: (data) {
      return const _i2.RootPage();
    },
  );
}

/// generated route for
/// [_i4.SignUpPage]
class SignUpRoute extends _i5.PageRouteInfo<void> {
  const SignUpRoute({List<_i5.PageRouteInfo>? children})
      : super(
          SignUpRoute.name,
          initialChildren: children,
        );

  static const String name = 'SignUpRoute';

  static _i5.PageInfo page = _i5.PageInfo(
    name,
    builder: (data) {
      return const _i4.SignUpPage();
    },
  );
}
