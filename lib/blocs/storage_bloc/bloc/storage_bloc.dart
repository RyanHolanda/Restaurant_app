import 'package:bloc/bloc.dart';
import 'package:car_app/firebase/storage/add_user_data.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

part 'storage_event.dart';
part 'storage_state.dart';

class StorageBloc extends Bloc<StorageEvent, StorageState> {
  StorageBloc() : super(StorageStateStorageInitial()) {
    on<StorageEventAddUserAdress>((event, emit) async {
      try {
        await Database().addUserAdress(event.userAdress);
      } on FirebaseException {
        print('deu erro mermão');
      }

    });
  }
}
