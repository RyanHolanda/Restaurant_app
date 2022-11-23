// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'cart_bloc.dart';

class CartState extends Equatable {
  final List<CartModel> cartItems;
  CartState({
    this.cartItems = const <CartModel>[],
  });
  @override
  List<Object> get props => [cartItems];
}
