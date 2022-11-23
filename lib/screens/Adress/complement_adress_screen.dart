// ignore_for_file: use_build_context_synchronously

import 'package:car_app/blocs/app_bloc.dart';
import 'package:car_app/firebase/storage/add_user_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geocoder2/geocoder2.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:icons_plus/icons_plus.dart';
import 'dart:math';

class ComplementAdressScreen extends StatefulWidget {
  const ComplementAdressScreen({super.key, required this.adrees});

  final String adrees;

  @override
  State<ComplementAdressScreen> createState() => _ComplementAdressScreenState();
}

class _ComplementAdressScreenState extends State<ComplementAdressScreen> {
  late String catchNumber = widget.adrees.split(',')[1].split('-')[0];
  late int _number = 0;
  double distanceFromStore = 0.0;

  TextEditingController complementController = TextEditingController();

  TextEditingController referenceController = TextEditingController();

  late TextEditingController numberController =
      TextEditingController(text: _number == 0 ? null : _number.toString());

  double calculateDistance(lat1, lon1, lat2, lon2) {
    var p = 0.017453292519943295;
    var a = 0.5 -
        cos((lat2 - lat1) * p) / 2 +
        cos(lat1 * p) * cos(lat2 * p) * (1 - cos((lon2 - lon1) * p)) / 2;
    setState(() {
      distanceFromStore = 12742 * asin(sqrt(a));
    });
    return 12742 * asin(sqrt(a));
  }

  getDistance() async {
    GeoData _userAress = await Geocoder2.getDataFromAddress(
        address: widget.adrees,
        googleMapApiKey: 'AIzaSyC_IeLigRUrh6nafTOWbGqtzV5h_1itk0A');

    GeoData _storeAddress = await Geocoder2.getDataFromAddress(
        address:
            'Rua Orindiuva, 28 - Jardim Elzinha, Carapicuíba - State of São Paulo',
        googleMapApiKey: 'AIzaSyC_IeLigRUrh6nafTOWbGqtzV5h_1itk0A');

    calculateDistance(_userAress.latitude, _userAress.longitude,
        _storeAddress.latitude, _storeAddress.longitude);
  }

  @override
  void initState() {
    getDistance();
    try {
      final number = int.parse(catchNumber);
      setState(() {
        _number = number;
      });
    } catch (e) {
      null;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppBloc, AppState>(
      builder: (context, state) {
        return GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: distanceFromStore > 12.0
              ? Scaffold(
                  appBar: AppBar(
                    backgroundColor: Colors.transparent,
                    elevation: 0,
                    iconTheme: IconThemeData(
                        color: Theme.of(context).colorScheme.primary),
                  ),
                  body: Padding(
                    padding: const EdgeInsets.all(50),
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            AppLocalizations.of(context)!.addressNotSupported,
                            textAlign: TextAlign.center,
                            style: GoogleFonts.inriaSans(
                                fontWeight: FontWeight.bold,
                                fontSize: 25,
                                color:
                                    Theme.of(context).colorScheme.onTertiary),
                          ),
                          SizedBox(height: 70,),
                          Image.network(
                            'https://cdn4.iconfinder.com/data/icons/feedback-1-2/48/2-512.png',
                            height: 200,
                          ),
                          SizedBox(
                            height: 50,
                          ),
                          Text(
                            AppLocalizations.of(context)!.weCantDeliver,
                            textAlign: TextAlign.center,
                            style: GoogleFonts.inriaSans(
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                                color:
                                    Theme.of(context).colorScheme.onTertiary),
                          ),
                        ],
                      ),
                    ),
                  ))
              : Scaffold(
                  appBar: AppBar(
                    title: Text(
                      AppLocalizations.of(context)!.addAComplement,
                      style: GoogleFonts.inriaSans(
                          color: Theme.of(context).colorScheme.primary),
                    ),
                    iconTheme: IconThemeData(
                        color: Theme.of(context).colorScheme.primary),
                    elevation: 0,
                    backgroundColor: Theme.of(context).colorScheme.secondary,
                  ),
                  body: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.all(15),
                      child: Column(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(15),
                            child: Container(
                              padding: EdgeInsets.all(20),
                              color: Theme.of(context).colorScheme.onPrimary,
                              child: Center(
                                  child: Text(
                                widget.adrees,
                                textAlign: TextAlign.center,
                                style: GoogleFonts.inriaSans(
                                    fontWeight: FontWeight.bold,
                                    color: Theme.of(context)
                                        .colorScheme
                                        .onTertiary),
                              )),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 50),
                            child: TextField(
                              controller: numberController,
                              onChanged: (value) => setState(() {
                                _number = int.parse(value);
                              }),
                              decoration: InputDecoration(
                                  label: Text(
                                      AppLocalizations.of(context)!.number),
                                  focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .primary),
                                      borderRadius: BorderRadius.circular(15)),
                                  enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .onTertiary),
                                      borderRadius: BorderRadius.circular(15))),
                            ),
                          ),
                          _number == 0
                              ? Padding(
                                  padding:
                                      const EdgeInsets.only(top: 8, left: 5),
                                  child: Align(
                                      alignment: Alignment.centerLeft,
                                      child: Text(
                                        AppLocalizations.of(context)!
                                            .addANumber,
                                        style: GoogleFonts.inriaSans(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.red),
                                      )),
                                )
                              : const SizedBox.shrink(),
                          Padding(
                            padding: const EdgeInsets.only(top: 20),
                            child: TextField(
                              controller: complementController,
                              decoration: InputDecoration(
                                  label: Text(
                                      AppLocalizations.of(context)!.complement),
                                  focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .primary),
                                      borderRadius: BorderRadius.circular(15)),
                                  enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .onTertiary),
                                      borderRadius: BorderRadius.circular(15))),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 20),
                            child: TextField(
                              controller: referenceController,
                              decoration: InputDecoration(
                                  label: Text(
                                      AppLocalizations.of(context)!.reference),
                                  focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .primary),
                                      borderRadius: BorderRadius.circular(15)),
                                  enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .onTertiary),
                                      borderRadius: BorderRadius.circular(15))),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 50),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(15),
                              child: SizedBox(
                                width: MediaQuery.of(context).size.width,
                                height: 50,
                                child: ElevatedButton.icon(
                                  icon: const Icon(FontAwesome.location_arrow),
                                  label: Text(AppLocalizations.of(context)!
                                      .saveAddress),
                                  onPressed: () async {
                                    _number == 0
                                        ? const Text('data')
                                        : await Database().addUserAdress(
                                            '${widget.adrees}, ${AppLocalizations.of(context)!.number}: ${numberController.text} ${referenceController.text} ${complementController.text}',
                                          );
                                    context
                                        .read<AppBloc>()
                                        .add(AppEventGetData());
                                    Navigator.pop(context);
                                    Navigator.pop(context);
                                  },
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
        );
      },
    );
  }
}
