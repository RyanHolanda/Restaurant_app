
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:icons_plus/icons_plus.dart';

class PickUpAdress extends StatelessWidget {
  const PickUpAdress({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: GestureDetector(
        child: SizedBox(
          child: Row(
            children: [
              const Padding(
                padding: EdgeInsets.only(top: 20, left: 15, right: 15),
                child: Icon(FontAwesome.shop),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 20),
                    child: Text(
                      AppLocalizations.of(context)!.pickUpAdress,
                      style: GoogleFonts.inriaSans(
                          color: Theme.of(context).colorScheme.onTertiary,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 5),
                    child: SizedBox(
                      width: 210,
                      child: Text(
                        'Rua Orindiuva - Jardim Elzinha 28',
                        style: GoogleFonts.inriaSans(
                            color: Theme.of(context).colorScheme.primary,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}