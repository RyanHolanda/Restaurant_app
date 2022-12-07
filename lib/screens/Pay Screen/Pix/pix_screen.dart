import 'package:car_app/blocs/payment_bloc/payment_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../approved_payment_screen.dart';
import 'pending_pix_screen.dart';

class PixScreen extends StatelessWidget {
  const PixScreen(
      {super.key,
      required this.isDelivery,
      required this.total,
      required this.meatPoint,
      required this.molhoOrMaionese,
      required this.wantSachets});

  final String meatPoint;
  final String wantSachets;
  final String molhoOrMaionese;
  final bool isDelivery;
  final double total;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PaymentBloc, PaymentState>(builder: (context, state) {
      if (state.isLoading == true) {
        return WillPopScope(
          onWillPop: () async => false,
          child: Scaffold(
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Lottie.asset('assets/loading_burguer.json', height: 200),
                  const SizedBox(
                    height: 15,
                  ),
                  Text(
                    AppLocalizations.of(context)!.generatingYourPIX,
                    style: GoogleFonts.inriaSans(fontWeight: FontWeight.bold),
                  )
                ],
              ),
            ),
          ),
        );
      }
      if (state is PixGenerated) {
        return PendingPixScreen(
          total: total,
        );
      }
      if (state is PixApproved) {
        return ApprovedPaymentScreen(
          isDelivery: isDelivery,
          meatPoint: meatPoint,
          molhoOrMaionese: molhoOrMaionese,
          wantSachets: wantSachets,
          paymentMethod: 'PIX',
          total: total,
        );
      } else {
        return const SizedBox.shrink();
      }
    });
  }
}
