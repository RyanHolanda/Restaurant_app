import 'package:car_app/blocs/home_bloc/home_bloc.dart';
import 'package:car_app/screens/Finish_Order/confirm_payment_method.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:page_transition/page_transition.dart';

class ShowMyModal extends StatelessWidget {
  const ShowMyModal(
      {super.key,
      required this.total,
      required this.meatPoint,
      required this.molhoOrMaionese,
      required this.wantSachets});
  final double total;
  final String meatPoint;
  final String wantSachets;
  final String molhoOrMaionese;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ClipRRect(
          borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(15), topRight: Radius.circular(15)),
          child: Container(
            padding: const EdgeInsets.all(15),
            height: MediaQuery.of(context).size.height / 2,
            color: Theme.of(context).colorScheme.secondary,
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                children: [
                  Text(
                    AppLocalizations.of(context)!.paymentMethod,
                    style: GoogleFonts.inriaSans(
                        fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(top: 50, left: 8, bottom: 15),
                    child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Pague no App',
                          style: GoogleFonts.inriaSans(
                              fontWeight: FontWeight.bold, fontSize: 16),
                        )),
                  ),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(15),
                    child: Container(
                      height: 50,
                      color: Theme.of(context).colorScheme.tertiary,
                      child: MaterialButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              PageTransition(
                                  child: BlocBuilder<HomeBloc, HomeState>(
                                    builder: (context, state) {
                                      return ConfirmPaymentMethodScreen(
                                          isDelivery: state is HomeStateDelivery
                                              ? true
                                              : false,
                                          meatPoint: meatPoint,
                                          molhoOrMaionese: molhoOrMaionese,
                                          wantSachets: wantSachets,
                                          total: total,
                                          icon: Icons.pix,
                                          paymentMethod: 'PIX');
                                    },
                                  ),
                                  type: PageTransitionType.fade));
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: const [
                            Icon(
                              Icons.pix_sharp,
                              color: Colors.teal,
                            ),
                            SizedBox(
                              width: 15,
                            ),
                            Text('PIX')
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(15),
                    child: Container(
                      height: 50,
                      color: Theme.of(context).colorScheme.tertiary,
                      child: MaterialButton(
                        onPressed: () {},
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Icon(
                              Bootstrap.credit_card_2_front,
                              color: Theme.of(context).colorScheme.onTertiary,
                            ),
                            const SizedBox(
                              width: 15,
                            ),
                            Text(AppLocalizations.of(context)!.creditCard)
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(15),
                    child: Container(
                      height: 50,
                      color: Theme.of(context).colorScheme.tertiary,
                      child: MaterialButton(
                        onPressed: () {},
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Icon(
                              Bootstrap.credit_card_2_front,
                              color: Theme.of(context).colorScheme.onTertiary,
                            ),
                            const SizedBox(
                              width: 15,
                            ),
                            Text(AppLocalizations.of(context)!.debitCard)
                          ],
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(top: 25, left: 8, bottom: 15),
                    child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          AppLocalizations.of(context)!.payOnDelivery,
                          style: GoogleFonts.inriaSans(
                              fontWeight: FontWeight.bold, fontSize: 16),
                        )),
                  ),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(15),
                    child: Container(
                      height: 50,
                      color: Theme.of(context).colorScheme.tertiary,
                      child: MaterialButton(
                        onPressed: () {},
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            const Icon(
                              Bootstrap.currency_dollar,
                              color: Colors.green,
                            ),
                            const SizedBox(
                              width: 15,
                            ),
                            Text(AppLocalizations.of(context)!.cash)
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(15),
                    child: Container(
                      height: 50,
                      color: Theme.of(context).colorScheme.tertiary,
                      child: MaterialButton(
                        onPressed: () {},
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Icon(
                              Bootstrap.credit_card_2_front,
                              color: Theme.of(context).colorScheme.onTertiary,
                            ),
                            const SizedBox(
                              width: 15,
                            ),
                            Text(
                                '${AppLocalizations.of(context)!.debitCard} / ${AppLocalizations.of(context)!.creditCard}')
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                ],
              ),
            ),
          )),
    );
  }
}
