import 'package:car_app/screens/Get%20_started/email_screen.dart';
import 'package:car_app/screens/login/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:page_transition/page_transition.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      extendBodyBehindAppBar: true,
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Image.asset(
            'assets/welcome-burguer-image.jpg',
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            fit: BoxFit.cover,
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 200),
            child: Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              decoration: const BoxDecoration(
                  gradient: LinearGradient(
                      colors: [Colors.black, Color.fromARGB(0, 0, 0, 0)],
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter)),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 200),
            child: Align(
              alignment: Alignment.center,
              child: Text(
                AppLocalizations.of(context)!.hello,
                style: GoogleFonts.pacifico(fontSize: 91, color: Colors.white),
              ),
            ),
          ),
          ClipRRect(
            borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(19), topRight: Radius.circular(19)),
            child: Container(
              width: MediaQuery.of(context).size.width,
              color: Theme.of(context).colorScheme.primaryContainer,
              height: MediaQuery.of(context).size.height / 2,
              child: Padding(
                padding: const EdgeInsets.only(left: 15, right: 15, top: 34),
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(
                            width: 270,
                            child: Text(
                              'Black Beard Burger',
                              style: GoogleFonts.inriaSans(
                                  fontSize: 32, fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width / 1.5,
                        child: Text(
                          AppLocalizations.of(context)!.yourFavoriteHamburguer,
                          maxLines: 3,
                          style: GoogleFonts.inriaSans(
                              fontSize: 32, fontWeight: FontWeight.w200),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 80, bottom: 10),
                        child: Align(
                          alignment: Alignment.bottomCenter,
                          child: Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                color: Theme.of(context).colorScheme.primary),
                            width: 250,
                            height: 60,
                            child: MaterialButton(
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    PageTransition(
                                        child: const EmailRegisterScreen(),
                                        type: PageTransitionType.fade));
                              },
                              child: Text(
                                AppLocalizations.of(context)!.getStarted,
                                style: GoogleFonts.inriaSans(
                                    color:
                                        Theme.of(context).colorScheme.secondary,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.center,
                        child: TextButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  PageTransition(
                                      child: const LoginScreen(),
                                      type: PageTransitionType.fade));
                            },
                            child: Text(
                              AppLocalizations.of(context)!
                                  .iAlreadyHaveAnAccount,
                              style: GoogleFonts.inriaSans(
                                  fontWeight: FontWeight.bold,
                                  decoration: TextDecoration.underline,
                                  color: Theme.of(context)
                                              .colorScheme
                                              .brightness ==
                                          Brightness.dark
                                      ? Colors.white
                                      : Colors.black),
                            )),
                      )
                    ],
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
