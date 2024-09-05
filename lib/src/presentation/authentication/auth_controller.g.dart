// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$authenticationStateHash() =>
    r'8d0bab6c5d7c176babb37ad5ecc7b2d410368422';

/// See also [authenticationState].
@ProviderFor(authenticationState)
final authenticationStateProvider = AutoDisposeStreamProvider<User?>.internal(
  authenticationState,
  name: r'authenticationStateProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$authenticationStateHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef AuthenticationStateRef = AutoDisposeStreamProviderRef<User?>;
String _$loginControllerHash() => r'82093124f579b35af85eb9a2ac723b5154984321';

/// See also [LoginController].
@ProviderFor(LoginController)
final loginControllerProvider =
    AutoDisposeAsyncNotifierProvider<LoginController, void>.internal(
  LoginController.new,
  name: r'loginControllerProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$loginControllerHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$LoginController = AutoDisposeAsyncNotifier<void>;
String _$registrationControllerHash() =>
    r'9f45d60431677d2a6c139e647841e9ba44a3efc5';

/// See also [RegistrationController].
@ProviderFor(RegistrationController)
final registrationControllerProvider =
    AutoDisposeAsyncNotifierProvider<RegistrationController, void>.internal(
  RegistrationController.new,
  name: r'registrationControllerProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$registrationControllerHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$RegistrationController = AutoDisposeAsyncNotifier<void>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
