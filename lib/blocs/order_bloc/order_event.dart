// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'order_bloc.dart';

abstract class OrderEvent extends Equatable {
  const OrderEvent();

  @override
  List<Object> get props => [];
}

@immutable
class OrderEventSendOrderToProduction extends OrderEvent {
  final String item;
  final double total;
  final String date;
  final String howMuchGonnaPay;
  final String clientPIXKey;
  final String adress;
  final String paymentMethod;
  final String wantSachets;
  final String molhoOrMaionese;
  final String meatPoint;
  final bool isDelivery;
  final String name;
  final bool cooking;
  final bool orderFinishedCook;
  final bool inDelivery;
  final bool completed;
  final int id;

  const OrderEventSendOrderToProduction({
    required this.date,
    required this.item,
    required this.total,
    required this.clientPIXKey,
    required this.howMuchGonnaPay,
    required this.adress,
    required this.paymentMethod,
    required this.wantSachets,
    required this.molhoOrMaionese,
    required this.meatPoint,
    required this.isDelivery,
    required this.name,
    required this.cooking,
    required this.orderFinishedCook,
    required this.inDelivery,
    required this.completed,
    required this.id,
  });
}

class AddUserPastOrders extends OrderEvent {
  final String item;
  final double total;
  final String adress;
  final String paymentMethod;
  final String wantSachets;
  final String molhoOrMaionese;
  final String meatPoint;
  final bool isDelivery;
  final String name;
  final bool cooking;
  final bool orderFinishedCook;
  final bool inDelivery;
  final bool completed;
  final String date;
  final int id;

  const AddUserPastOrders({
    required this.date,
    required this.item,
    required this.total,
    required this.adress,
    required this.paymentMethod,
    required this.wantSachets,
    required this.molhoOrMaionese,
    required this.meatPoint,
    required this.isDelivery,
    required this.name,
    required this.cooking,
    required this.orderFinishedCook,
    required this.inDelivery,
    required this.completed,
    required this.id,
  });
}
