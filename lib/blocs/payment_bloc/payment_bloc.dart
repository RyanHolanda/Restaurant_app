import 'dart:async';
import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:car_app/blocs/cart_bloc/cart_bloc.dart';
import 'package:car_app/models/pix_payment_info_model.dart';
import 'package:car_app/repos/pix_payment_repo.dart';
import 'package:equatable/equatable.dart';

part 'payment_event.dart';
part 'payment_state.dart';

class PaymentBloc extends Bloc<PaymentEvent, PaymentState> {
  PaymentBloc() : super(PaymentInitial(isLoading: false)) {
    on<PaymentEventPayInPix>((event, emit) async {
      emit(GeneratingPix(isLoading: true));
      try {
        final pixID = await CreatePixToPay(
                transactionAmount: event.amount.toDouble(), email: event.email)
            .createPixToPay();
        final pix = await GetPixData(id: pixID.id).getPixInfo();
        pixInfo = pix;
        emit(PixGenerated(isLoading: false));
        Timer.periodic(const Duration(seconds: 15), (timer) async {
          final pix = await GetPixData(id: pixID.id).getPixInfo();
          if (pix.status == 'approved') {
            add(PaymentEventPaid());
            timer.cancel();
          }
        });
      } catch (e) {}
    });
    on<PaymentEventPaid>((event, emit) {
      emit(PixApproved(isLoading: false));
    });
  }
}
