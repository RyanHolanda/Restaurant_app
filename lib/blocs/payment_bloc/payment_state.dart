part of 'payment_bloc.dart';

abstract class PaymentState extends Equatable {
  bool isLoading;
  PaymentState({required this.isLoading});
}

class PaymentInitial extends PaymentState {
  PaymentInitial({required isLoading}) : super(isLoading: isLoading);

  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}

class GeneratingPix extends PaymentState {
  GeneratingPix({required isLoading}) : super(isLoading: isLoading);

  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}

class PixApproved extends PaymentState {
  PixApproved({required isLoading}) : super(isLoading: isLoading);

  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}

class PixGenerated extends PaymentState {
  PixGenerated({required isLoading}) : super(isLoading: isLoading);
  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}
