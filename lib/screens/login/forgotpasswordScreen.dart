import 'package:car_app/auth/auth_error.dart';
import 'package:car_app/blocs/app_bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

@immutable
class ForgotPasswordScreen extends StatelessWidget {
  ForgotPasswordScreen({super.key});
  final TextEditingController _emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocListener<AppBloc, AppState>(
      listener: (context, state) {
        if (state is AppStateAuthError) {
          switch (authErrorResetPassword) {
            case 'Not found user error':
              authErrorResetPassword =
                  AppLocalizations.of(context)!.noCurrentUser;
              break;
          }
          showDialog(
              context: context,
              builder: (context) => CupertinoAlertDialog(
                    content: Text(authErrorResetPassword),
                    actions: [
                      TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: const Text('Ok'))
                    ],
                  ));
        }
        if (state is AppStateSendResetEmail) {
          showDialog(
            context: context,
            builder: (context) => CupertinoAlertDialog(
              title: Text(AppLocalizations.of(context)!.emailSucessfullySent),
              actions: [
                TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text('Ok'))
              ],
              content: Text(AppLocalizations.of(context)!
                  .emailSucessfullySentDialogContent),
            ),
          );
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
                      AppLocalizations.of(context)!.recoverPassword,
                      style: GoogleFonts.inriaSans(
                          fontSize: 34, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 20, bottom: 25),
                    child: Text(
                      AppLocalizations.of(context)!
                          .insertYourEmailtoRecoverYourPassword,
                      style: GoogleFonts.inriaSans(
                          color: Theme.of(context).colorScheme.onTertiary),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 20, right: 20),
                    child: SizedBox(
                      height: 60,
                      width: MediaQuery.of(context).size.width,
                      child: TextField(
                        controller: _emailController,
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                            hintText: AppLocalizations.of(context)!.email,
                            hintStyle: TextStyle(
                                color:
                                    Theme.of(context).colorScheme.onTertiary),
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide.none),
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(9),
                                borderSide: BorderSide.none),
                            filled: true,
                            fillColor: Theme.of(context).colorScheme.onPrimary),
                      ),
                    ),
                  ),
                  Padding(
                      padding:
                          const EdgeInsets.only(left: 20, top: 20, right: 20),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: state.isLoading
                            ? const Align(
                                alignment: Alignment.center,
                                child: CircularProgressIndicator())
                            : Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(9),
                                    gradient: LinearGradient(
                                        colors: [
                                          Colors.grey.shade900,
                                          Colors.grey.shade800
                                        ],
                                        begin: Alignment.centerLeft,
                                        end: Alignment.centerRight)),
                                width: MediaQuery.of(context).size.width,
                                height: 60,
                                child: MaterialButton(
                                  onPressed: () {
                                    context.read<AppBloc>().add(
                                        AppEventResetPassword(
                                            email: _emailController.text));
                                  },
                                  child: Text(
                                    AppLocalizations.of(context)!.sendEmail,
                                    style: GoogleFonts.inriaSans(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20,
                                        color: Colors.white),
                                  ),
                                ),
                              ),
                      )),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
