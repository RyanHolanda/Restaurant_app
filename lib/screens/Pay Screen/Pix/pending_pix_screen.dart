import 'dart:async';

import 'package:car_app/models/pix_payment_info_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class PendingPixScreen extends StatefulWidget {
  PendingPixScreen({super.key, required this.total});

  double total;

  @override
  State<PendingPixScreen> createState() => _PendingPixScreenState();
}

class _PendingPixScreenState extends State<PendingPixScreen> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        body: Center(
          child: SingleChildScrollView(
            child: Center(
              child: SafeArea(
                child: Wrap(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(15),
                      child: Center(
                        child: Column(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(15),
                                  boxShadow: [
                                    BoxShadow(
                                        spreadRadius: 0.5,
                                        blurRadius: 12,
                                        offset: const Offset(5, 5),
                                        color: Theme.of(context)
                                                    .colorScheme
                                                    .brightness ==
                                                Brightness.light
                                            ? Colors.grey.shade300
                                            : Colors.transparent),
                                    BoxShadow(
                                        spreadRadius: 0.5,
                                        blurRadius: 12,
                                        offset: const Offset(-5, -5),
                                        color: Theme.of(context)
                                                    .colorScheme
                                                    .brightness ==
                                                Brightness.light
                                            ? Colors.grey.shade100
                                            : Colors.transparent),
                                  ]),
                              padding: const EdgeInsets.all(15),
                              width: MediaQuery.of(context).size.width / 1.3,
                              child: Center(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    QrImage(
                                      data: pixInfo!.paymentKey.toString(),
                                      size: MediaQuery.of(context).size.height /
                                          3,
                                      backgroundColor: Colors.white,
                                    ),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    Text(
                                      '${AppLocalizations.of(context)!.recipient} Isaque da Silva',
                                      style: GoogleFonts.inriaSans(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black,
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    Text(
                                      '${AppLocalizations.of(context)!.institution} Mercado Pago lp LTDA.',
                                      style: GoogleFonts.inriaSans(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black),
                                    ),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    Text(
                                      '${AppLocalizations.of(context)!.amount} R\$ ${widget.total.toStringAsFixed(2)}',
                                      style: GoogleFonts.inriaSans(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 25),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(15),
                                child: Container(
                                    padding: const EdgeInsets.all(15),
                                    color:
                                        Theme.of(context).colorScheme.tertiary,
                                    width:
                                        MediaQuery.of(context).size.width / 1.3,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        Text(
                                          AppLocalizations.of(context)!
                                              .copyAndPastePix,
                                          style: GoogleFonts.inriaSans(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 16),
                                        ),
                                        const SizedBox(
                                          height: 15,
                                        ),
                                        SelectableText(
                                          pixInfo!.paymentKey.toString(),
                                          style: const TextStyle(
                                              fontWeight: FontWeight.bold),
                                        ),
                                        IconButton(
                                            onPressed: () async {
                                              await Clipboard.setData(
                                                      ClipboardData(
                                                          text: pixInfo!
                                                              .paymentKey))
                                                  .then((value) =>
                                                      ScaffoldMessenger.of(
                                                              context)
                                                          .showSnackBar(
                                                              SnackBar(
                                                                  backgroundColor:
                                                                      Colors
                                                                          .green,
                                                                  content: Text(
                                                                    AppLocalizations.of(
                                                                            context)!
                                                                        .copiedToClipboard,
                                                                    style: const TextStyle(
                                                                        fontWeight:
                                                                            FontWeight
                                                                                .bold,
                                                                        color: Colors
                                                                            .white),
                                                                  ))));
                                            },
                                            icon: const Icon(Icons.copy)),
                                      ],
                                    )),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Center(
                        child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Lottie.asset('assets/yellow_alert.json', height: 50),
                        Text(
                          AppLocalizations.of(context)!.pendingPayment,
                          style: GoogleFonts.inriaSans(
                              color: Colors.amber.shade300,
                              fontSize: 20,
                              fontWeight: FontWeight.bold),
                        ),
                        Lottie.asset('assets/yellow_alert.json', height: 50),
                      ],
                    )),
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
