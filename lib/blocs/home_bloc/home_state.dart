part of 'home_bloc.dart';

abstract class HomeState extends Equatable {
  const HomeState();
}

class InitialState extends HomeState {
  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}

class HomeStatePickUp extends HomeState {
  @override
  List<Object?> get props => throw UnimplementedError();
}

class HomeStateDelivery extends HomeState {
  @override
  List<Object?> get props => throw UnimplementedError();
}
