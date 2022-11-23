// ignore: depend_on_referenced_packages
import 'package:bloc/bloc.dart';
import 'package:car_app/firebase/auth/auth.dart';
import 'package:car_app/firebase/auth/auth_error.dart';
import 'package:car_app/firebase/storage/add_user_data.dart';
import 'package:car_app/models/items_model.dart';
import 'package:car_app/models/store_status_model.dart';
import 'package:car_app/repos/items_repository.dart';
import 'package:car_app/repos/store_status_repo.dart';
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
            Database().addUserNumber(event.phoneNumber);
        add(AppEventGetData());
      } on FirebaseAuthException catch (e) {
        emit(AppStateAuthError(
            isLoading: false, authError: AuthError.from(e).text));
        authErrorRegister = state.authError.toString();
      }
    });

    on<AppEventGetData>((event, emit) async {
      emit(const AppStateLoggedIn(isLoading: true));
      try {
        final items = await ItemsRepository().getItems();
        itemsList = items;
        final storeS =await StoreStatusRepo().getStoreStatus();
        storeStatus = storeS;
        await Database().getUserAdress();
        emit(const AppStateLoggedIn(isLoading: false));
      } catch (e) {
        print(e);
        add(AppEventGetData());
      }
    });

    on<AppEventlogIn>((event, emit) async {
      emit(const AppStateLoggedOut(isLoading: true));
      try {
        await Auth().signInWithEmailAndPassword(
          email: event.email,
          password: event.password,
        );
        add(AppEventGetData());
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
        final user = Auth().currentUser;
        if (user?.uid == null) {
          throw FirebaseAuthException(code: 'Unknown error');
        } else {
          add(AppEventGetData());
        }
      } on FirebaseAuthException catch (e) {
        emit(AppStateAuthError(
            isLoading: false, authError: AuthError.from(e).text));
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
        emit(AppStateAuthError(
            isLoading: false, authError: AuthError.from(e).text));
        authErrorResetPassword = state.authError.toString();
      }
    });
  }
}
