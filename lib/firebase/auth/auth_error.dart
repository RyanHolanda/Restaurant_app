import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';

  String authErrorLogin = '';
  String authErrorRegisterEmail = ''; 
  String authErrorRegisterPassword = '';
  String authErrorRegister = '';
  String authErrorResetPassword = '';

const Map<String, AuthError> authErrorMapping = {
  'user-not-found': AuthErrorUserNoFound(),
  'weak-password': AuthErrorWeakPassword(),
  'invalid E-mail': AuthErrorInvalidEmail(),
  'email-already-in-use':AuthErrorEmailInUse(),
  'wrong-password': AuthErrorWrongPassword(),
  'too-many-requests': AutherrorTooManyRequests(),
  'invalid-email': AuthErrorInvalidEmail()
};

@immutable
class AuthError {
  final String text;

  const AuthError({required this.text});

  factory AuthError.from(FirebaseAuthException exception) =>
  authErrorMapping[exception.code.toLowerCase().trim()] ?? const AuthErrorUnknown();
}

@immutable
class AuthErrorUnknown extends AuthError {
   const AuthErrorUnknown()
      : super(
         text: 'Unknown error'
        );
}

@immutable
class AuthErrorUserNoFound extends AuthError {
  const AuthErrorUserNoFound()
      : super(
          text: 'Not found user error'
        );
}

@immutable
class AuthErrorWeakPassword extends AuthError {
  const AuthErrorWeakPassword()
      : super(
          text: 'Invalid Password error'
        );
}

@immutable
class AuthErrorInvalidEmail extends AuthError {
  const AuthErrorInvalidEmail()
      : super(
          text: 'Invalid E-mail error'
        );
}

@immutable
class AuthErrorEmailInUse extends AuthError {
  const AuthErrorEmailInUse()
      : super(
          text: 'E-mail already in use error'
        );
}

@immutable
class AuthErrorWrongPassword extends AuthError {
  const AuthErrorWrongPassword()
      : super(
          text: 'Wrong password error'
        );
}

@immutable
class AutherrorTooManyRequests extends AuthError {
  const AutherrorTooManyRequests()
      : super(
          text: 'Too many requests error'
        );
}