// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'cart_bloc.dart';

abstract class CartEvent extends Equatable {
  const CartEvent();
}

@immutable
class AddItemToCart extends CartEvent {
  final CartModel item;
  const AddItemToCart({
    required this.item,
  });
  @override
  List<Object> get props => [item];
}

@immutable
class DeleteItemFromCart extends CartEvent {
  final CartModel item;
  const DeleteItemFromCart({
    required this.item,
  });
  @override
  List<Object> get props => [item];
}

@immutable
class UpdateItemInCart extends CartEvent {
  final CartModel item;
  const UpdateItemInCart({
    required this.item,
  });
  @override
  List<Object> get props => [item];
}
