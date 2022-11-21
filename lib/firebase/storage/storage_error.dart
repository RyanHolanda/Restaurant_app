import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';

  String storageError = '';


const Map<String, StorageError> authErrorMapping = {
  'not-found': StorageErrorDcumentNotFound(),

};

@immutable
class StorageError {
  final String text;
  const StorageError({required this.text});
  factory StorageError.from(FirebaseAuthException exception) =>
  authErrorMapping[exception.code.toLowerCase().trim()] ?? const AuthErrorUnknown();
}

@immutable
class AuthErrorUnknown extends StorageError {
   const AuthErrorUnknown()
      : super(
         text: 'Unknown error'
        );
}

@immutable
class StorageErrorDcumentNotFound extends StorageError {
  const StorageErrorDcumentNotFound()
      : super(
          text: 'Not found document error'
        );
}

