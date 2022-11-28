import 'package:car_app/screens/login/forgot_password_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:page_transition/page_transition.dart';

import '../../firebase/auth/auth_error.dart';
import '../../blocs/app_bloc.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

bool _visiblePassword = true;

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocListener<AppBloc, AppState>(
      listener: (context, state) {
        if (state is AppStateLoggedIn) {
          Navigator.pop(context);
        }
      },
      child: BlocBuilder<AppBloc, AppState>(
        builder: (context, state) {
          return GestureDetector(
            onTap: () => FocusScope.of(context).unfocus(),
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
                        AppLocalizations.of(context)!.hello,
                        style: GoogleFonts.inriaSans(
                            fontSize: 34, fontWeight: FontWeight.bold),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 20, bottom: 25, right: 25),
                      child: Text(
                        AppLocalizations.of(context)!
                            .insertYourEmailandPasswordtoLogin,
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
                          textInputAction: TextInputAction.next,
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
                              fillColor:
                                  Theme.of(context).colorScheme.onPrimary),
                        ),
                      ),
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.only(left: 20, top: 10, right: 20),
                      child: SizedBox(
                        height: 60,
                        width: MediaQuery.of(context).size.width,
                        child: TextField(
                          controller: _passwordController,
                          obscureText: _visiblePassword,
                          keyboardType: TextInputType.visiblePassword,
                          decoration: InputDecoration(
                            suffixIcon: GestureDetector(
                                onTap: () => setState(() {
                                      _visiblePassword = !_visiblePassword;
                                    }),
                                child: Icon(
                                  _visiblePassword
                                      ? FontAwesome.eye
                                      : FontAwesome.eye_slash,
                                  color:
                                      Theme.of(context).colorScheme.onTertiary,
                                  size: 20,
                                )),
                            hintText: AppLocalizations.of(context)!.password,
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
                            fillColor:
                                Theme.of(context).colorScheme.brightness ==
                                        Brightness.dark
                                    ? Colors.grey.shade900
                                    : Colors.grey.shade300,
                          ),
                        ),
                      ),
                    ),
                    LayoutBuilder(
                      builder: (p0, p1) {
                        switch (authErrorLogin) {
                          case 'Too many requests error':
                            authErrorLogin =
                                AppLocalizations.of(context)!.tooManyRequests;
                            break;
                          case 'Wrong password error':
                            authErrorLogin =
                                AppLocalizations.of(context)!.invalidPassword;
                            break;
                          case 'Unknown error':
                            authErrorLogin =
                                AppLocalizations.of(context)!.unknownError;
                            break;
                          case 'Not found user error':
                            authErrorLogin =
                                AppLocalizations.of(context)!.noCurrentUser;
                            break;
                          case 'Invalid password error':
                            authErrorLogin =
                                AppLocalizations.of(context)!.invalidPassword;
                            break;
                          case 'Invalid E-mail error':
                            authErrorLogin =
                                AppLocalizations.of(context)!.invalidEmail;
                            break;
                        }
                        return Padding(
                          padding: const EdgeInsets.only(left: 25, top: 5),
                          child: Text(
                            authErrorLogin,
                            style: GoogleFonts.inriaSans(
                                height: 0,
                                color: Colors.red,
                                fontWeight: FontWeight.bold),
                          ),
                        );
                      },
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 20, top: 5),
                      child: TextButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                PageTransition(
                                    child: ForgotPasswordScreen(),
                                    type: PageTransitionType.fade));
                          },
                          child: Text(
                            AppLocalizations.of(context)!.forgotMyPassword,
                            style: GoogleFonts.inriaSans(
                                decoration: TextDecoration.underline,
                                fontWeight: FontWeight.bold),
                          )),
                    ),
                    Padding(
                        padding:
                            const EdgeInsets.only(left: 20, top: 10, right: 20),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: state.isLoading
                              ? Align(
                                  alignment: Alignment.center,
                                  child: CircularProgressIndicator(
                                    color:
                                        Theme.of(context).colorScheme.primary,
                                  ),
                                )
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
                                      context.read<AppBloc>().add(AppEventlogIn(
                                          email: _emailController.text,
                                          password: _passwordController.text));
                                    },
                                    child: Text(
                                      AppLocalizations.of(context)!.signIn,
                                      style: GoogleFonts.inriaSans(
                                          color: Colors.white,
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ),
                        )),
                    Padding(
                      padding: const EdgeInsets.only(top: 70, bottom: 50),
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
                            context
                                .read<AppBloc>()
                                .add(AppEventEnterWithGoogle());
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
                                    AppLocalizations.of(context)!
                                        .signinWithGoogle,
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
        },
      ),
    );
  }
}
