// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'payment_bloc.dart';

abstract class PaymentEvent extends Equatable {}

class PaymentEventPaid extends PaymentEvent {
  @override
  List<Object?> get props => throw UnimplementedError();
}

class PaymentEventPayInPix extends PaymentEvent {
  double amount;
  String email;
  PaymentEventPayInPix({
    required this.amount,
    required this.email,
  });
  @override
  List<Object?> get props => throw UnimplementedError();
}
