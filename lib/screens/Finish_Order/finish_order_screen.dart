import 'dart:async';

import 'package:car_app/blocs/home_bloc/home_bloc.dart';
import 'package:car_app/firebase/storage/add_user_data.dart';
import 'package:car_app/models/user_data_models.dart';
import 'package:car_app/screens/Adress/input_adress_screen.dart';
import 'package:car_app/screens/Finish_Order/widgets/payment_method_modal.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:page_transition/page_transition.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';
import 'package:url_launcher/url_launcher.dart';

class FinishOrderScreen extends StatefulWidget {
  FinishOrderScreen(
      {super.key, required this.shippingPrice, required this.total});

  final double shippingPrice;
  final double total;

  @override
  State<FinishOrderScreen> createState() => _FinishOrderScreenState();
}

class _FinishOrderScreenState extends State<FinishOrderScreen> {
  String radioValue1 = null.toString();
  String radioValue2 = null.toString();
  String radioValue3 = null.toString();

  @override
  Widget build(BuildContext context) {
    Database().getUserAdress();
    Database().getUserDistance();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.secondary,
        elevation: 0,
        iconTheme: IconThemeData(color: Theme.of(context).colorScheme.primary),
        title: Text(
          AppLocalizations.of(context)!.finishMyOrder,
          style: TextStyle(color: Theme.of(context).colorScheme.primary),
        ),
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: BlocBuilder<HomeBloc, HomeState>(
                  builder: (context, state) {
                    return GestureDetector(
                      onTap: () {
                        Timer.periodic(const Duration(seconds: 1),
                            (timer) => setState(() {}));
                        setState(() {});
                        state is HomeStateDelivery
                            ? Navigator.push(
                                context,
                                PageTransition(
                                    child: const InputAdressScreen(),
                                    type: PageTransitionType.bottomToTop))
                            : launchUrl(
                                Uri.parse(
                                    'https://www.google.com/maps/place/R.+Orindiuva,+28+-+Jardim+Elzinha,+Carapicu%C3%ADba+-+SP,+06362-030/@-23.5563651,-46.8444203,20.12z/data=!4m5!3m4!1s0x94cf00388513b4f7:0x2982d36f4e6ee87f!8m2!3d-23.5565137!4d-46.8440269'),
                                mode: LaunchMode.externalApplication);
                      },
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
                                        MediaQuery.of(context).size.width / 1.5,
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
                                                    fontWeight: FontWeight.bold,
                                                    color: Theme.of(context)
                                                        .colorScheme
                                                        .onTertiary),
                                                overflow: TextOverflow.ellipsis,
                                              )
                                            : Text(
                                                'Rua Orindiuva, 28 - Jardim Elzinha, Carapicuíba - São Paulo, Brazil',
                                                maxLines: 2,
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    color: Theme.of(context)
                                                        .colorScheme
                                                        .onTertiary),
                                                overflow: TextOverflow.ellipsis,
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
                                        onPressed: () {
                                          Navigator.push(
                                              context,
                                              PageTransition(
                                                  child:
                                                      const InputAdressScreen(),
                                                  type: PageTransitionType
                                                      .bottomToTop));
                                        },
                                        icon: const Icon(Icons.location_pin))
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
                                        icon: const Icon(
                                            Icons.arrow_circle_right_outlined));
                              },
                            )
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 20, horizontal: 5),
                child: Text(
                  '${AppLocalizations.of(context)!.wouldYouLikeSachetsOfKetchupAndMustard} *',
                  style: GoogleFonts.inriaSans(
                      color: Theme.of(context).colorScheme.onTertiary,
                      fontWeight: FontWeight.bold,
                      fontSize: 16),
                ),
              ),
              RadioListTile(
                value: 'sim',
                groupValue: radioValue1,
                onChanged: (value) {
                  setState(() {
                    radioValue1 = value!;
                  });
                },
                title: Text(AppLocalizations.of(context)!.yes),
              ),
              RadioListTile(
                value: 'nao',
                groupValue: radioValue1,
                onChanged: (value) {
                  setState(() {
                    radioValue1 = value!;
                  });
                },
                title: Text(AppLocalizations.of(context)!.no),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 20, horizontal: 5),
                child: Text(
                  '${AppLocalizations.of(context)!.whatDoYouPrefer} *',
                  style: GoogleFonts.inriaSans(
                      color: Theme.of(context).colorScheme.onTertiary,
                      fontWeight: FontWeight.bold,
                      fontSize: 16),
                ),
              ),
              RadioListTile(
                value: 'Molho grill',
                groupValue: radioValue2,
                onChanged: (value) {
                  setState(() {
                    radioValue2 = value!;
                  });
                },
                title: const Text('Molho grill'),
              ),
              RadioListTile(
                value: 'Maionese verde',
                groupValue: radioValue2,
                onChanged: (value) {
                  setState(() {
                    radioValue2 = value!;
                  });
                },
                title: const Text('Maionese verde'),
              ),
              RadioListTile(
                value: 'nao',
                groupValue: radioValue2,
                onChanged: (value) {
                  setState(() {
                    radioValue2 = value!;
                  });
                },
                title: Text(AppLocalizations.of(context)!.noThanks),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 20, horizontal: 5),
                child: Text(
                  '${AppLocalizations.of(context)!.howWouldYouLikeYourSteak} *',
                  style: GoogleFonts.inriaSans(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: Theme.of(context).colorScheme.onTertiary),
                ),
              ),
              RadioListTile(
                value: 'Ao ponto',
                groupValue: radioValue3,
                onChanged: (value) {
                  setState(() {
                    radioValue3 = value!;
                  });
                },
                title: Text(AppLocalizations.of(context)!.medium),
              ),
              RadioListTile(
                value: 'Bem passada',
                groupValue: radioValue3,
                onChanged: (value) {
                  setState(() {
                    radioValue3 = value!;
                  });
                },
                title: Text(AppLocalizations.of(context)!.wellDone),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(15),
            child: SizedBox(
              height: 50,
              child: MaterialButton(
                color: Theme.of(context).colorScheme.primary,
                onPressed: () {
                  if (radioValue1 == null.toString() ||
                      radioValue2 == null.toString() ||
                      radioValue3 == null.toString()) {
                    showTopSnackBar(
                        Overlay.of(context)!,
                        CustomSnackBar.error(
                            message: AppLocalizations.of(context)!
                                .youNeedToselectAllOptions,
                            textStyle: GoogleFonts.inriaSans(
                                fontWeight: FontWeight.bold,
                                color:
                                    Theme.of(context).colorScheme.onSecondary),
                            icon: const Icon(
                              Icons.error_outline,
                              size: 80,
                              color: Color.fromARGB(56, 0, 0, 0),
                            )),
                        displayDuration: const Duration(milliseconds: 2000));
                  } else {
                    showModalBottomSheet(
                      context: context,
                      builder: (context) => ShowMyModal(
                        meatPoint: radioValue3,
                        molhoOrMaionese: radioValue2,
                        wantSachets: radioValue1,
                        total: widget.total,
                      ),
                      backgroundColor: Colors.transparent,
                    );
                  }
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Bootstrap.check,
                      color: Theme.of(context).colorScheme.secondary,
                    ),
                    Text(
                      AppLocalizations.of(context)!.continuee,
                      style: TextStyle(
                          color: Theme.of(context).colorScheme.secondary),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
