part of 'order_bloc.dart';

abstract class OrderState extends Equatable {
  const OrderState();

  @override
  List<Object> get props => [];
}

class OrderStateOrderInitial extends OrderState {}

class OrderStateOrderSent extends OrderState {}
