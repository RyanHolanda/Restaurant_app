import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:icons_plus/icons_plus.dart';

class UserAdress extends StatelessWidget {
  const UserAdress({
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
                child: Icon(FontAwesome.bicycle),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 20),
                    child: Text(
                      AppLocalizations.of(context)!.receiveYourOrderIn30m1h,
                      style: GoogleFonts.inriaSans(
                          color: Theme.of(context).colorScheme.onTertiary,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 5),
                    child: SizedBox(
                      width: 200,
                      child: Text(
                        'Rua orindiuva - Jardim Elzinha 32, APTo 52 Bloco G',
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
                      onPressed: () {}, icon: const Icon(Icons.navigate_next)),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}