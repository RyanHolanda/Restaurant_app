import 'package:bloc/bloc.dart';
import 'package:car_app/models/cart_model.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

part 'cart_event.dart';
part 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  CartBloc() : super(CartState()) {
    on<AddItemToCart>((event, emit) {
      emit(CartState(cartItems: List.from(state.cartItems)..add(event.item)));
      print(event.item);
    });

    on<UpdateItemInCart>((event, emit) {
    });

    on<DeleteItemFromCart>((event, emit) {
    });
  }
}
