part of 'storage_bloc.dart';

abstract class StorageEvent extends Equatable {
  const StorageEvent();
}

@immutable
class StorageEventAddUserAdress extends StorageEvent {
  String userAdress = 'adereço';
  @override
  List<Object?> get props => throw UnimplementedError();
}