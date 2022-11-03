part of 'home_bloc.dart';

abstract class HomeEvent extends Equatable {
}

@immutable
class HomeEventGoToPickupSection extends HomeEvent{
  @override
  List<Object?> get props => throw UnimplementedError();
  }

  @immutable
class HomeEventGoToDeliverySection extends HomeEvent{
  @override
  List<Object?> get props => throw UnimplementedError();
  }
