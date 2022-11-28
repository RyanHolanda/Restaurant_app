import 'package:car_app/firebase/storage/add_user_data.dart';
import 'package:car_app/models/user_data_models.dart';
import 'package:car_app/screens/Adress/input_adress_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:page_transition/page_transition.dart';

class FinishOrderScreen extends StatefulWidget {
  FinishOrderScreen(
      {super.key,
      required this.homeState,
      required this.shippingPrice,
      required this.total});

  String homeState;
  final double shippingPrice;
  final double? total;

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
                child: GestureDetector(
                  onTap: () => Navigator.push(
                      context,
                      PageTransition(
                          child: const InputAdressScreen(),
                          type: PageTransitionType.bottomToTop)),
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
                            Text(
                              widget.homeState == 'Delivery'
                                  ? '${AppLocalizations.of(context)!.shippingAdress}'
                                  : '${AppLocalizations.of(context)!.pickUpAdress}',
                              style: GoogleFonts.inriaSans(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                  color:
                                      Theme.of(context).colorScheme.onTertiary),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 10),
                              child: SizedBox(
                                width: MediaQuery.of(context).size.width / 1.5,
                                child: Text(
                                  userAdressModelString ??
                                      AppLocalizations.of(context)!.addAnAdress,
                                  maxLines: 2,
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Theme.of(context)
                                          .colorScheme
                                          .onTertiary),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        IconButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  PageTransition(
                                      child: const InputAdressScreen(),
                                      type: PageTransitionType.bottomToTop));
                            },
                            icon: const Icon(Icons.edit))
                      ],
                    ),
                  ),
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
                title: const Text('Ao ponto'),
              ),
              RadioListTile(
                value: 'Bem passada',
                groupValue: radioValue3,
                onChanged: (value) {
                  setState(() {
                    radioValue3 = value!;
                  });
                },
                title: const Text('Bem passada'),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Padding(
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
                  showDialog(
                    context: context,
                    builder: (context) => CupertinoAlertDialog(
                      content: Text(AppLocalizations.of(context)!
                          .youNeedToselectAllOptions),
                      actions: [
                        TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: const Text('Ok'))
                      ],
                    ),
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
    );
  }
}
