import 'package:bloc/bloc.dart';
import 'package:car_app/auth/auth.dart';
import 'package:car_app/auth/auth_error.dart';
import 'package:car_app/screens/Get%20_started/text_controllers/text_controllers.dart';
import 'package:car_app/screens/Get%20_started/email_screen.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';

part 'app_event.dart';
part 'app_state.dart';

class AppBloc extends Bloc<AppEvent, AppState> {
  AppBloc() : super(AppStateLoggedOut(isLoading: false)) {
    on<AppEventRegister>((event, emit) async {
      emit(AppStateLoggedOut(isLoading: true));
      try {
        await Auth().createUserWithEmailAndPassword(
            email: event.email,
            password: event.password,
            phoneNumber: event.phoneNumber);
        emit(AppStateLoggedIn(isLoading: false));
      } on FirebaseAuthException catch (e) {
        emit(AppStateAuthError(
            isLoading: false, authError: AuthError.from(e).text));
        authErrorRegister = state.authError.toString();
        print(e);
        print(state.authError.toString());
      }
    });

    on<AppEventlogIn>((event, emit) async {
      emit(AppStateLoggedOut(isLoading: true));
      try {
        await Auth().signInWithEmailAndPassword(
          email: event.email,
          password: event.password,
        );
        emit(AppStateLoggedIn(isLoading: false));
      } on FirebaseAuthException catch (e) {
        emit(AppStateAuthError(
            isLoading: false, authError: AuthError.from(e).text));
        authErrorLogin = state.authError.toString();
      }
    });

    on<AppEventSignOut>((event, emit) async {
      emit(AppStateLoggedOut(isLoading: true));
      try {
        await Auth().signOut();
        emit(AppStateLoggedOut(isLoading: false));
      } on FirebaseAuthException catch (e) {}
    });

    on<AppEventEnterWithGoogle>((event, emit) async {
      emit(AppStateLoggedOut(isLoading: true));
      try {
        await Auth().signInWithGoogle();
        emit(AppStateLoggedIn(isLoading: false));
      } on FirebaseAuthException catch (e) {
        emit(AppStateAuthError(isLoading: false, authError: AuthError.from(e).text));
        authErrorLogin = state.authError.toString();
        authErrorRegister = state.authError.toString();
      }
    });

    on<AppEventResetPassword>((event, emit) async {
      emit(AppStateLoggedOut(isLoading: true));
      try {
        await Auth().sendPasswordResetEmail(email: event.email);
        emit(AppStateSendResetEmail(isLoading: false));
      } on FirebaseAuthException catch (e) {
        emit(AppStateAuthError(isLoading: false, authError: AuthError.from(e).text));
        authErrorResetPassword = state.authError.toString();
        print(e);
      }
    });
  }
}
