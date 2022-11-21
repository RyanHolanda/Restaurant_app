import 'package:car_app/firebase/auth/auth_error.dart';
import 'package:car_app/screens/Get%20_started/text_controllers/text_controllers.dart';
import 'package:car_app/screens/Get%20_started/password_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:page_transition/page_transition.dart';

import '../../blocs/app_bloc.dart';

class EmailRegisterScreen extends StatefulWidget {
  const EmailRegisterScreen({super.key});

  @override
  State<EmailRegisterScreen> createState() => _EmailRegisterScreenState();
}

class _EmailRegisterScreenState extends State<EmailRegisterScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocListener<AppBloc, AppState>(
      listener: (context, state) {
        if (state is AppStateAuthError) {
          showDialog(
              context: context,
              builder: (context) => CupertinoAlertDialog(
                    content: Text(authErrorRegister),
                    actions: [
                      TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: const Text('Ok'))
                    ],
                  ));
        }
        if (state is AppStateLoggedIn) {
          Navigator.popUntil(context, (route) => route.isFirst);
        }
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.secondary,
          elevation: 0,
          iconTheme:
              IconThemeData(color: Theme.of(context).colorScheme.primary),
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 20, top: 35),
                child: Text(
                  AppLocalizations.of(context)!.welcome,
                  style: GoogleFonts.inriaSans(
                      fontSize: 34, fontWeight: FontWeight.bold),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20, bottom: 25),
                child: Text(
                  AppLocalizations.of(context)!
                      .insertYourEmailtoCreateYourAccount,
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
                        controller: emailController,
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                            hintText: AppLocalizations.of(context)!.email,
                            hintStyle: TextStyle(
                                color:
                                    Theme.of(context).colorScheme.onTertiary),
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
                            colors: [
                              Colors.grey.shade900,
                              Colors.grey.shade800
                            ],
                            begin: Alignment.centerLeft,
                            end: Alignment.centerRight),
                      ),
                      width: MediaQuery.of(context).size.width / 7.5,
                      height: 59.5,
                      child: GestureDetector(
                        onTap: () {
                          if (emailController.text.contains('@')) {
                            setState(() {
                              authErrorRegisterEmail = '';
                            });
                            Navigator.push(
                                context,
                                PageTransition(
                                    child: const PasswordRegisterScreen(),
                                    type: PageTransitionType.fade));
                          } else {
                            setState(() {
                              authErrorRegisterEmail =
                                  AppLocalizations.of(context)!.invalidEmail;
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
                  authErrorRegisterEmail,
                  style:
                      const TextStyle(fontWeight: FontWeight.bold, color: Colors.red),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 100, bottom: 50),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      color: Theme.of(context).colorScheme.onTertiary,
                      height: 1,
                      width: 100,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Text(
                        AppLocalizations.of(context)!.or,
                        style: GoogleFonts.inriaSans(
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).colorScheme.onTertiary,
                        ),
                      ),
                    ),
                    Container(
                      color: Theme.of(context).colorScheme.onTertiary,
                      height: 1,
                      width: 100,
                    ),
                  ],
                ),
              ),
              Align(
                alignment: Alignment.center,
                child: Container(
                  decoration: BoxDecoration(
                      boxShadow: const [
                        BoxShadow(color: Colors.black, blurRadius: 0.1)
                      ],
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.white),
                  height: 60,
                  width: 250,
                  child: MaterialButton(
                    onPressed: () {
                      context.read<AppBloc>().add(AppEventEnterWithGoogle());
                    },
                    child: Align(
                        alignment: Alignment.centerLeft,
                        child: Row(
                          children: [
                            Logo(
                              Logos.google,
                              size: 20,
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Text(
                              AppLocalizations.of(context)!.signupWithGoogle,
                              style: GoogleFonts.inriaSans(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        )),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
