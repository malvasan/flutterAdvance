import 'dart:developer';

enum StorageExceptionType {
  imageNotLocalStorage,
  imageNotUplodaded,
  unknown,
}

class StorageException implements Exception {
  StorageException({this.error, required this.type, required this.message}) {
    log(message);
  }
  Object? error;
  StorageExceptionType type;
  String message;
}
