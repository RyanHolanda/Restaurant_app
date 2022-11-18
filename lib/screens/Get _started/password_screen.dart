import 'package:car_app/auth/auth_error.dart';
import 'package:car_app/screens/Get%20_started/text_controllers/text_controllers.dart';
import 'package:car_app/screens/Get%20_started/phone_number.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:page_transition/page_transition.dart';

class PasswordRegisterScreen extends StatefulWidget {
  const PasswordRegisterScreen({super.key});

  @override
  State<PasswordRegisterScreen> createState() => _PasswordRegisterScreenState();
}

class _PasswordRegisterScreenState extends State<PasswordRegisterScreen> {
  bool _visiblePassword = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.secondary,
        elevation: 0,
        iconTheme: IconThemeData(color: Theme.of(context).colorScheme.primary),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 20, top: 35),
              child: Text(
                AppLocalizations.of(context)!.password,
                style: GoogleFonts.inriaSans(
                    fontSize: 34, fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20, bottom: 25),
              child: Text(
                AppLocalizations.of(context)!.createaPassword,
                style: GoogleFonts.inriaSans(
                    color: Theme.of(context).colorScheme.onTertiary),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 10),
              child: Row(
                children: [
                  SizedBox(
                    height: 60,
                    width: MediaQuery.of(context).size.width / 1.3,
                    child: TextField(
                      controller: passwordcontroller,
                      obscureText: _visiblePassword,
                      decoration: InputDecoration(
                          suffixIcon: GestureDetector(
                              onTap: () => setState(() {
                                    _visiblePassword = !_visiblePassword;
                                  }),
                              child: Icon(
                                _visiblePassword
                                    ? FontAwesome.eye
                                    : FontAwesome.eye_slash,
                                color: Theme.of(context).colorScheme.onTertiary,
                                size: 20,
                              )),
                          hintText: AppLocalizations.of(context)!.password,
                          hintStyle: TextStyle(
                              color: Theme.of(context).colorScheme.onTertiary),
                          enabledBorder: const OutlineInputBorder(
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(9),
                                  bottomLeft: Radius.circular(9)),
                              borderSide: BorderSide.none),
                          focusedBorder: const OutlineInputBorder(
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(9),
                                  bottomLeft: Radius.circular(9)),
                              borderSide: BorderSide.none),
                          filled: true,
                          fillColor: Theme.of(context).colorScheme.onPrimary),
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.only(
                          topRight: Radius.circular(10),
                          bottomRight: Radius.circular(10)),
                      gradient: LinearGradient(
                          colors: [Colors.grey.shade900, Colors.grey.shade800],
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight),
                    ),
                    width: MediaQuery.of(context).size.width / 7.5,
                    height: 59.5,
                    child: GestureDetector(
                      onTap: () {
                        if (passwordcontroller.text.characters.length < 6) {
                          setState(() {
                            authErrorRegisterPassword =
                                AppLocalizations.of(context)!.invalidPasswordRegister;
                          });
                        } else {
                          Navigator.push(
                              context,
                              PageTransition(
                                  child: const PhoneRegistrationScreen(),
                                  type: PageTransitionType.fade));
                          setState(() {
                            authErrorRegisterPassword = '';
                          });
                        }
                      },
                      child: const Align(
                        alignment: Alignment.center,
                        child: Icon(
                          Icons.navigate_next,
                          size: 35,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 25, top: 15),
              child: Text(
                authErrorRegisterPassword,
                style:
                    const TextStyle(fontWeight: FontWeight.bold, color: Colors.red),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
