import 'dart:async';

import 'package:car_app/firebase/auth/auth.dart';
import 'package:car_app/firebase/storage/add_user_data.dart';
import 'package:car_app/screens/Profile/profile_screen.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:car_app/models/user_data_models.dart';
import 'package:car_app/screens/Adress/input_adress_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:page_transition/page_transition.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../blocs/home_bloc/home_bloc.dart';
import '../../blocs/payment_bloc/payment_bloc.dart';
import '../Pay Screen/Pix/approved_payment_screen.dart';
import '../Pay Screen/Pix/pix_screen.dart';

class ConfirmPaymentMethodScreen extends StatefulWidget {
  const ConfirmPaymentMethodScreen(
      {super.key,
      required this.isDelivery,
      required this.meatPoint,
      required this.wantSachets,
      required this.molhoOrMaionese,
      required this.paymentMethod,
      required this.icon,
      required this.payymentMethodID,
      required this.total});

  final String paymentMethod;
  final IconData icon;
  final double total;
  final String meatPoint;
  final String wantSachets;
  final String molhoOrMaionese;
  final bool isDelivery;
  final String payymentMethodID;

  @override
  State<ConfirmPaymentMethodScreen> createState() =>
      _ConfirmPaymentMethodScreenState();
}

class _ConfirmPaymentMethodScreenState
    extends State<ConfirmPaymentMethodScreen> {
  TextEditingController howMuchGonnaPayController = TextEditingController();
  TextEditingController clientPIXKey = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Database().getUserName();
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            '${AppLocalizations.of(context)!.payIn} ${widget.paymentMethod}',
            style: TextStyle(color: Theme.of(context).colorScheme.primary),
          ),
          iconTheme:
              IconThemeData(color: Theme.of(context).colorScheme.primary),
          elevation: 0,
          backgroundColor: Theme.of(context).colorScheme.secondary,
        ),
        body: BlocBuilder<HomeBloc, HomeState>(
          builder: (context, state) {
            return SingleChildScrollView(
              child: Padding(
                  padding: const EdgeInsets.all(15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(15),
                        child: GestureDetector(
                          onTap: () => state is HomeStateDelivery
                              ? null
                              : launchUrl(
                                  Uri.parse(
                                      'https://www.google.com/maps/place/R.+Orindiuva,+28+-+Jardim+Elzinha,+Carapicu%C3%ADba+-+SP,+06362-030/@-23.5563651,-46.8444203,20.12z/data=!4m5!3m4!1s0x94cf00388513b4f7:0x2982d36f4e6ee87f!8m2!3d-23.5565137!4d-46.8440269'),
                                  mode: LaunchMode.externalApplication),
                          child: Container(
                            padding: const EdgeInsets.all(15),
                            height: 120,
                            color: Theme.of(context).colorScheme.tertiary,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    BlocBuilder<HomeBloc, HomeState>(
                                      builder: (context, state) {
                                        return Text(
                                          state is HomeStateDelivery
                                              ? '${AppLocalizations.of(context)!.shippingAdress}'
                                              : '${AppLocalizations.of(context)!.pickUpAdress}',
                                          style: GoogleFonts.inriaSans(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 18,
                                              color: Theme.of(context)
                                                  .colorScheme
                                                  .onTertiary),
                                        );
                                      },
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(top: 10),
                                      child: SizedBox(
                                        width:
                                            MediaQuery.of(context).size.width /
                                                1.5,
                                        child: BlocBuilder<HomeBloc, HomeState>(
                                          builder: (context, state) {
                                            return state is HomeStateDelivery
                                                ? Text(
                                                    userAdressModelString ??
                                                        AppLocalizations.of(
                                                                context)!
                                                            .addAnAdress,
                                                    maxLines: 2,
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: Theme.of(context)
                                                            .colorScheme
                                                            .onTertiary),
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                  )
                                                : Text(
                                                    'Rua Orindiuva, 28 - Jardim Elzinha, Carapicuíba - São Paulo, Brazil',
                                                    maxLines: 2,
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: Theme.of(context)
                                                            .colorScheme
                                                            .onTertiary),
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                  );
                                          },
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  width: 5,
                                ),
                                BlocBuilder<HomeBloc, HomeState>(
                                  builder: (context, state) {
                                    return state is HomeStateDelivery
                                        ? IconButton(
                                            onPressed: () {},
                                            icon:
                                                const Icon(Icons.location_pin))
                                        : IconButton(
                                            onPressed: () {
                                              Navigator.push(
                                                  context,
                                                  PageTransition(
                                                      child:
                                                          const InputAdressScreen(),
                                                      type: PageTransitionType
                                                          .bottomToTop));
                                            },
                                            icon: const Icon(Icons
                                                .arrow_circle_right_outlined));
                                  },
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 8, top: 50),
                        child: Text(
                          AppLocalizations.of(context)!.paymentMethod,
                          style: GoogleFonts.inriaSans(
                              fontWeight: FontWeight.bold, fontSize: 16),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8),
                        child: Row(
                          children: [
                            Icon(widget.icon),
                            const SizedBox(
                              width: 10,
                            ),
                            Text(widget.paymentMethod)
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 8, top: 25),
                        child: Text(
                          'Total',
                          style: GoogleFonts.inriaSans(
                              fontWeight: FontWeight.bold, fontSize: 16),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8),
                        child: Row(
                          children: [
                            Text('R\$ ${widget.total.toStringAsFixed(2)}')
                          ],
                        ),
                      ),
                      widget.payymentMethodID == 'Dinheiro'
                          ? const SizedBox(
                              height: 10,
                            )
                          : const SizedBox.shrink(),
                      widget.payymentMethodID == 'Dinheiro'
                          ? Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 15, horizontal: 5),
                              child: Text(
                                AppLocalizations.of(context)!.howMuchGonnaPay,
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold),
                              ),
                            )
                          : const SizedBox.shrink(),
                      widget.payymentMethodID == 'Dinheiro'
                          ? TextField(
                              keyboardType: TextInputType.number,
                              controller: howMuchGonnaPayController,
                              decoration: InputDecoration(
                                  prefixText: 'R\$ ',
                                  enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(15),
                                      borderSide: BorderSide(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .tertiary)),
                                  focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(15),
                                      borderSide: BorderSide(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .primary)),
                                  label: Text(
                                      AppLocalizations.of(context)!.value)),
                            )
                          : const SizedBox.shrink(),
                      widget.payymentMethodID == 'Dinheiro'
                          ? Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 5, vertical: 15),
                              child: Text(
                                AppLocalizations.of(context)!
                                    .ifYouNeedChangeWeGonnaPayinPix,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.yellow.shade800),
                              ),
                            )
                          : const SizedBox.shrink(),
                      widget.payymentMethodID == 'Dinheiro'
                          ? TextField(
                              controller: clientPIXKey,
                              decoration: InputDecoration(
                                  enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(15),
                                      borderSide: BorderSide(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .tertiary)),
                                  focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(15),
                                      borderSide: BorderSide(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .primary)),
                                  label: Text(
                                      AppLocalizations.of(context)!.pixKey)),
                            )
                          : const SizedBox.shrink(),
                      const SizedBox(
                        height: 25,
                      ),
                      Center(
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(15),
                          child: SizedBox(
                            width: MediaQuery.of(context).size.width,
                            child: BlocBuilder<PaymentBloc, PaymentState>(
                              builder: (context, state) {
                                return state.isLoading
                                    ? const CircularProgressIndicator()
                                    : ElevatedButton.icon(
                                        style: ButtonStyle(
                                            padding: MaterialStateProperty.all(
                                                const EdgeInsets.all(15))),
                                        onPressed: () async {
                                          if (userNameString == null ||
                                              userNameString == null ||
                                              userAdressModelString == null) {
                                            Timer.periodic(
                                                const Duration(seconds: 1),
                                                (timer) {
                                              setState(() {});
                                              if (userNameString != null &&
                                                  userAdressModelString !=
                                                      null &&
                                                  userNumberModelString !=
                                                      null) {
                                                timer.cancel();
                                              }
                                            });
                                            showTopSnackBar(
                                                Overlay.of(context)!,
                                                CustomSnackBar.error(
                                                    message: AppLocalizations
                                                            .of(context)!
                                                        .youNeedToFillAllInformations,
                                                    textStyle:
                                                        GoogleFonts.inriaSans(
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            color: Theme.of(
                                                                    context)
                                                                .colorScheme
                                                                .onSecondary),
                                                    icon: const Icon(
                                                      Bootstrap.card_checklist,
                                                      size: 70,
                                                      color: Color.fromARGB(
                                                          56, 0, 0, 0),
                                                    )),
                                                onTap: () {},
                                                displayDuration: const Duration(
                                                    milliseconds: 2000));
                                            Navigator.push(
                                                context,
                                                PageTransition(
                                                    child: ProfileScreen(),
                                                    type: PageTransitionType
                                                        .rightToLeftWithFade));
                                          }
                                          if (userAdressModelString != null &&
                                              userNameString != null &&
                                              userNumberModelString != null) {
                                            if (widget.paymentMethod == 'PIX') {
                                              final user = Auth().currentUser;
                                              context.read<PaymentBloc>().add(
                                                  PaymentEventPayInPix(
                                                      amount: widget.total,
                                                      email: user!.email!));
                                              showTopSnackBar(
                                                  persistent: false,
                                                  Overlay.of(context)!,
                                                  CustomSnackBar.info(
                                                      maxLines: 4,
                                                      message:
                                                          AppLocalizations.of(
                                                                  context)!
                                                              .dontCloseApp,
                                                      textStyle:
                                                          GoogleFonts.inriaSans(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              color: Theme.of(
                                                                      context)
                                                                  .colorScheme
                                                                  .onSecondary),
                                                      icon: const Icon(
                                                        Bootstrap
                                                            .exclamation_circle,
                                                        size: 80,
                                                        color: Color.fromARGB(
                                                            56, 0, 0, 0),
                                                      )),
                                                  displayDuration:
                                                      const Duration(
                                                          seconds: 5));
                                              Navigator.pushReplacement(
                                                  context,
                                                  PageTransition(
                                                      child: PixScreen(
                                                        isDelivery:
                                                            widget.isDelivery,
                                                        meatPoint:
                                                            widget.meatPoint,
                                                        molhoOrMaionese: widget
                                                            .molhoOrMaionese,
                                                        wantSachets:
                                                            widget.wantSachets,
                                                        total: widget.total,
                                                      ),
                                                      type: PageTransitionType
                                                          .bottomToTop));
                                            }
                                            if (widget.payymentMethodID ==
                                                'Dinheiro') {
                                              if (clientPIXKey.text.isEmpty ||
                                                  howMuchGonnaPayController
                                                      .text.isEmpty ||
                                                  clientPIXKey.text.characters
                                                          .length <
                                                      10) {
                                                showTopSnackBar(
                                                    Overlay.of(context)!,
                                                    CustomSnackBar.error(
                                                        message: AppLocalizations
                                                                .of(context)!
                                                            .youNeedToFillAllInformations,
                                                        textStyle: GoogleFonts
                                                            .inriaSans(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                color: Theme.of(
                                                                        context)
                                                                    .colorScheme
                                                                    .onSecondary),
                                                        icon: const Icon(
                                                          Bootstrap
                                                              .card_checklist,
                                                          size: 70,
                                                          color: Color.fromARGB(
                                                              56, 0, 0, 0),
                                                        )),
                                                    onTap: () {},
                                                    displayDuration:
                                                        const Duration(
                                                            milliseconds:
                                                                2000));
                                              } else {
                                                Navigator.pushReplacement(
                                                    context,
                                                    PageTransition(
                                                        child: ApprovedPaymentScreen(
                                                            howMuchGonnaPay:
                                                                howMuchGonnaPayController
                                                                    .text,
                                                            clientPIXKey:
                                                                clientPIXKey
                                                                    .text,
                                                            isDelivery: widget
                                                                .isDelivery,
                                                            meatPoint: widget
                                                                .meatPoint,
                                                            molhoOrMaionese: widget
                                                                .molhoOrMaionese,
                                                            wantSachets: widget
                                                                .wantSachets,
                                                            total: widget.total,
                                                            paymentMethod: widget
                                                                .payymentMethodID),
                                                        type: PageTransitionType
                                                            .fade));
                                              }
                                            }
                                            if (widget.payymentMethodID ==
                                                'Cartao') {
                                              Navigator.pushReplacement(
                                                  context,
                                                  PageTransition(
                                                      child: ApprovedPaymentScreen(
                                                          howMuchGonnaPay: null,
                                                          clientPIXKey: null,
                                                          isDelivery:
                                                              widget.isDelivery,
                                                          meatPoint:
                                                              widget.meatPoint,
                                                          molhoOrMaionese: widget
                                                              .molhoOrMaionese,
                                                          wantSachets: widget
                                                              .wantSachets,
                                                          total: widget.total,
                                                          paymentMethod: widget
                                                              .payymentMethodID),
                                                      type: PageTransitionType
                                                          .fade));
                                            }
                                          }
                                        },
                                        icon: const Icon(Icons.check),
                                        label: Text(
                                            AppLocalizations.of(context)!
                                                .confirmMyOrder));
                              },
                            ),
                          ),
                        ),
                      )
                    ],
                  )),
            );
          },
        ),
      ),
    );
  }
}
