import 'dart:developer';

enum AuthExceptionType {
  wrongPassword,
  userNotFound,
  weakPassword,
  emailUsed,
  unknown,
}

class AuthException implements Exception {
  AuthException({this.error, required this.type, required this.message}) {
    log(message);
  }
  Object? error;
  AuthExceptionType type;
  String message;
}
