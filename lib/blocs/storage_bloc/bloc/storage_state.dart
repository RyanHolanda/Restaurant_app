part of 'storage_bloc.dart';

abstract class StorageState extends Equatable {
  final String? storageError;
  const StorageState({this.storageError});

  @override
  List<Object> get props => [];
}

class StorageStateStorageInitial extends StorageState {
  const StorageStateStorageInitial();
}

class StorageStateStorageSucessfullyAdded extends StorageState {
  const StorageStateStorageSucessfullyAdded();
}

class StorageStateStorageError extends StorageState {
  const StorageStateStorageError({String? storageError})
  :super(storageError: storageError);
}
