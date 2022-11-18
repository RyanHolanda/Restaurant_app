import 'package:car_app/auth/auth_error.dart';
import 'package:car_app/blocs/app_bloc.dart';
import 'package:car_app/screens/Get%20_started/text_controllers/text_controllers.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class PhoneRegistrationScreen extends StatefulWidget {
  const PhoneRegistrationScreen({super.key});

  @override
  State<PhoneRegistrationScreen> createState() =>
      _PhoneRegistrationScreenState();
}

class _PhoneRegistrationScreenState extends State<PhoneRegistrationScreen> {
  String invalidPhone = '';

  @override
  Widget build(BuildContext context) {
    return BlocListener<AppBloc, AppState>(
      listener: (context, state) {
        if (state is AppStateAuthError) {
          switch (authErrorRegister) {
          case 'Invalid E-mail error':
            authErrorRegister = AppLocalizations.of(context)!.invalidEmail;
            Navigator.pop(context);
            Navigator.pop(context);
            break;
          case 'Unkwnown error':
            authErrorRegister = AppLocalizations.of(context)!.unknownError;
            break;
          case 'E-mail already in use error':
            authErrorRegister =
                AppLocalizations.of(context)!.emailAlreadyExists;
            Navigator.pop(context);
            Navigator.pop(context);
            Navigator.pop(context);
            break;
        }
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
      child: BlocBuilder<AppBloc, AppState>(
        builder: (context, state) {
          return Scaffold(
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
                      AppLocalizations.of(context)!.almostDone,
                      style: GoogleFonts.inriaSans(
                          fontSize: 34, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 20, bottom: 25, right: 20),
                    child: Text(
                      AppLocalizations.of(context)!
                          .weNeedYourPhoneNumberToCreateYourAccount,
                      style: GoogleFonts.inriaSans(
                          color: Theme.of(context).colorScheme.onTertiary),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 20,
                      right: 10,
                    ),
                    child: Row(
                      children: [
                        SizedBox(
                          height: 60,
                          width: MediaQuery.of(context).size.width / 1.3,
                          child: TextField(
                            controller: phoneController,
                            style: const TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 16),
                            textAlignVertical: TextAlignVertical.center,
                            keyboardType: TextInputType.phone,
                            decoration: InputDecoration(
                                prefixIcon: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 15, horizontal: 15),
                                  child: SizedBox(
                                    width: 71,
                                    child: Row(
                                      children: [
                                        Flag(
                                          Flags.brazil,
                                        ),
                                        const Align(
                                            alignment: Alignment.center,
                                            child: Text(
                                              '  +55',
                                              style: TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.bold),
                                            ))
                                      ],
                                    ),
                                  ),
                                ),
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
                                fillColor:
                                    Theme.of(context).colorScheme.onPrimary),
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
                              if (phoneController.text.length > 11 ||
                                  phoneController.text.length < 11) {
                                setState(() {
                                  invalidPhone = AppLocalizations.of(context)!
                                      .invalidPhoneNumber;
                                });
                              }
                              if (phoneController.text.length == 11) {
                                setState(() {
                                  invalidPhone = '';
                                });
                                context.read<AppBloc>().add(AppEventRegister(
                                    email: emailController.text,
                                    password: passwordcontroller.text,
                                    phoneNumber:
                                        int.parse(phoneController.text)));
                              }
                            },
                            child: Align(
                              alignment: Alignment.center,
                              child: state.isLoading
                                  ? const CircularProgressIndicator(
                                      color:
                                          Colors.white,
                                    )
                                  : const Icon(
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
                      invalidPhone,
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.red),
                    ),
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
