import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:url_launcher/url_launcher.dart';

class PickUpAdress extends StatelessWidget {
  const PickUpAdress({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: GestureDetector(
        onTap: () => launchUrl(
            Uri.parse(
                'https://www.google.com/maps/place/R.+Orindiuva,+28+-+Jardim+Elzinha,+Carapicu%C3%ADba+-+SP,+06362-030/@-23.5563651,-46.8444203,20.12z/data=!4m5!3m4!1s0x94cf00388513b4f7:0x2982d36f4e6ee87f!8m2!3d-23.5565137!4d-46.8440269'),
            mode: LaunchMode.externalApplication),
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
                        'Rua Orindiuva, 28 - Jardim Elzinha, Carapicuíba - São Paulo, Brazil',
                        style: GoogleFonts.inriaSans(
                            color: Theme.of(context).colorScheme.primary,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20, left: 5),
                child: Align(
                  alignment: Alignment.centerRight,
                  child: IconButton(
                      onPressed: () {
                        launchUrl(
                            Uri.parse(
                                'https://www.google.com/maps/place/R.+Orindiuva,+28+-+Jardim+Elzinha,+Carapicu%C3%ADba+-+SP,+06362-030/@-23.5563651,-46.8444203,20.12z/data=!4m5!3m4!1s0x94cf00388513b4f7:0x2982d36f4e6ee87f!8m2!3d-23.5565137!4d-46.8440269'),
                            mode: LaunchMode.externalApplication);
                      },
                      icon: const Icon(Icons.arrow_circle_right_outlined)),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
