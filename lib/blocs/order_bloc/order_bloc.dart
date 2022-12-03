import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

import 'package:car_app/models/cart_model.dart';
import 'package:car_app/repos/send_order_repo.dart';

part 'order_event.dart';
part 'order_state.dart';

class OrderBloc extends Bloc<OrderEvent, OrderState> {
  OrderBloc() : super(OrderStateOrderInitial()) {
    on<OrderEventSendOrderToProduction>((event, emit) async {
      print('sending order');
      await SendOrderToProduction(
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
      print('order sent');
    });
  }
}
