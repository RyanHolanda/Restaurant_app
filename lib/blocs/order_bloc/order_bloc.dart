import 'package:bloc/bloc.dart';
import 'package:car_app/firebase/storage/add_user_data.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

import 'package:car_app/models/cart_model.dart';
import 'package:car_app/repos/send_order_repo.dart';

part 'order_event.dart';
part 'order_state.dart';

class OrderBloc extends Bloc<OrderEvent, OrderState> {
  OrderBloc() : super(OrderStateOrderInitial()) {
    on<OrderEventSendOrderToProduction>((event, emit) async {
      await SendOrderToProduction(
              date: event.date,
              meatPoint: event.meatPoint,
              molhoOrMaionese: event.molhoOrMaionese,
              wantSachets: event.wantSachets,
              isDelivey: event.isDelivery,
              paymentMethod: event.paymentMethod,
              orderFinishedCook: event.orderFinishedCook,
              inDelivery: event.inDelivery,
              completed: event.completed,
              cooking: event.cooking,
              id: event.id,
              name: event.name,
              adress: event.adress,
              item: event.item,
              total: event.total)
          .sendOrderToProduction();
      emit(OrderStateOrderSent());
    });

    on<AddUserPastOrders>((event, emit) async {
      await UserOrders(
              date: event.date,
              adress: event.adress,
              completed: event.completed,
              cooking: event.cooking,
              id: event.id,
              inDelivery: event.inDelivery,
              isDelivey: event.isDelivery,
              item: event.item,
              meatPoint: event.meatPoint,
              molhoOrMaionese: event.molhoOrMaionese,
              name: event.name,
              orderFinishedCook: event.orderFinishedCook,
              paymentMethod: event.paymentMethod,
              total: event.total,
              wantSachets: event.wantSachets)
          .addUserOrdersToDatabase();
      emit(OrderStateOrderAddedToPastOrders());
    });
  }
}
