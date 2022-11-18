// ignore: depend_on_referenced_packages
import 'package:bloc/bloc.dart';
import 'package:car_app/auth/auth.dart';
import 'package:car_app/auth/auth_error.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';

part 'app_event.dart';
part 'app_state.dart';

class AppBloc extends Bloc<AppEvent, AppState> {
  AppBloc() : super(const AppStateLoggedOut(isLoading: false)) {
    on<AppEventRegister>((event, emit) async {
      emit(const AppStateLoggedOut(isLoading: true));
      try {
        await Auth().createUserWithEmailAndPassword(
            email: event.email,
            password: event.password,
            phoneNumber: event.phoneNumber);
        emit(const AppStateLoggedIn(isLoading: false));
      } on FirebaseAuthException catch (e) {
        emit(AppStateAuthError(
            isLoading: false, authError: AuthError.from(e).text));
        authErrorRegister = state.authError.toString();
      }
    });

    on<AppEventlogIn>((event, emit) async {
      emit(const AppStateLoggedOut(isLoading: true));
      try {
        await Auth().signInWithEmailAndPassword(
          email: event.email,
          password: event.password,
        );
        emit(const AppStateLoggedIn(isLoading: false));
      } on FirebaseAuthException catch (e) {
        emit(AppStateAuthError(
            isLoading: false, authError: AuthError.from(e).text));
        authErrorLogin = state.authError.toString();
      }
    });

    on<AppEventSignOut>((event, emit) async {
      emit(const AppStateLoggedOut(isLoading: true));
      try {
        await Auth().signOut();
        emit(const AppStateLoggedOut(isLoading: false));
      } on FirebaseAuthException catch (e) {}
    });

    on<AppEventEnterWithGoogle>((event, emit) async {
      emit(const AppStateLoggedOut(isLoading: true));
      try {
        await Auth().signInWithGoogle();
        emit(const AppStateLoggedIn(isLoading: false));
      } on FirebaseAuthException catch (e) {
        emit(AppStateAuthError(isLoading: false, authError: AuthError.from(e).text));
        authErrorLogin = state.authError.toString();
        authErrorRegister = state.authError.toString();
      }
    });

    on<AppEventResetPassword>((event, emit) async {
      emit(const AppStateLoggedOut(isLoading: true));
      try {
        await Auth().sendPasswordResetEmail(email: event.email);
        emit(const AppStateSendResetEmail(isLoading: false));
      } on FirebaseAuthException catch (e) {
        emit(AppStateAuthError(isLoading: false, authError: AuthError.from(e).text));
        authErrorResetPassword = state.authError.toString();
      }
    });
  }
}
