import 'package:car_app/blocs/app_bloc.dart';
import 'package:car_app/firebase/auth/auth.dart';
import 'package:car_app/firebase/storage/add_user_data.dart';
import 'package:car_app/models/user_data_models.dart';
import 'package:car_app/screens/Adress/input_adress_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:page_transition/page_transition.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';
import 'package:url_launcher/url_launcher.dart';

class ProfileScreen extends StatelessWidget {
  ProfileScreen({super.key});

  final FocusNode nameFocusnode = FocusNode();
  final FocusNode numberFocusnode = FocusNode();

  @override
  Widget build(BuildContext context) {
    final user = Auth().currentUser;
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            AppLocalizations.of(context)!.profile,
            style: GoogleFonts.inriaSans(
                color: Theme.of(context).colorScheme.primary,
                fontWeight: FontWeight.bold),
          ),
          backgroundColor: Theme.of(context).colorScheme.secondary,
          elevation: 0,
          iconTheme:
              IconThemeData(color: Theme.of(context).colorScheme.primary),
        ),
        body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.all(15),
            child: Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(
                    Bootstrap.person_circle,
                    color: Theme.of(context).colorScheme.onTertiary,
                    size: MediaQuery.of(context).size.width / 4,
                  ),
                  Padding(
                      padding: const EdgeInsets.symmetric(vertical: 25),
                      child: Text(
                        user!.email!,
                        style: GoogleFonts.inriaSans(fontSize: 18),
                      )),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(15),
                    child: GestureDetector(
                      onTap: () => Navigator.push(
                          context,
                          PageTransition(
                              child: const InputAdressScreen(),
                              type: PageTransitionType.bottomToTop)),
                      child: Container(
                        padding: const EdgeInsets.all(15),
                        height: 120,
                        color: Theme.of(context).colorScheme.tertiary,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  '${AppLocalizations.of(context)!.shippingAdress} *',
                                  style: GoogleFonts.inriaSans(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18,
                                      color: Theme.of(context)
                                          .colorScheme
                                          .onTertiary),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 10),
                                  child: SizedBox(
                                    width:
                                        MediaQuery.of(context).size.width / 1.5,
                                    child: Text(
                                      userAdressModelString ??
                                          AppLocalizations.of(context)!
                                              .addAnAdress,
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            IconButton(
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      PageTransition(
                                          child: const InputAdressScreen(),
                                          type:
                                              PageTransitionType.bottomToTop));
                                },
                                icon: const Icon(Icons.edit))
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(15),
                    child: GestureDetector(
                      onTap: () => FocusScope.of(context).focusedChild,
                      child: Container(
                        padding: const EdgeInsets.all(15),
                        height: 120,
                        color: Theme.of(context).colorScheme.tertiary,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  '${AppLocalizations.of(context)!.nameAndMiddleName} *',
                                  style: GoogleFonts.inriaSans(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18,
                                      color: Theme.of(context)
                                          .colorScheme
                                          .onTertiary),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(right: 0),
                                  child: SizedBox(
                                    width:
                                        MediaQuery.of(context).size.width / 1.5,
                                    height: 60,
                                    child: TextField(
                                      focusNode: nameFocusnode,
                                      onChanged: (value) {
                                        if (value.characters.length > 3) {
                                          Database().addUserName(value);
                                          Database().getUserName();
                                        }
                                      },
                                      controller: TextEditingController(
                                          text: userNameString),
                                      textAlign: TextAlign.start,
                                      decoration: InputDecoration(
                                          hintText:
                                              AppLocalizations.of(context)!
                                                  .addAName,
                                          contentPadding:
                                              const EdgeInsets.symmetric(
                                                  vertical: 10),
                                          border: const OutlineInputBorder(
                                              borderSide: BorderSide.none)),
                                      maxLines: 1,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            IconButton(
                                onPressed: () {
                                  nameFocusnode.requestFocus();
                                },
                                icon: const Icon(Icons.edit))
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(15),
                    child: GestureDetector(
                      onTap: () => FocusScope.of(context).focusedChild,
                      child: Container(
                        padding: const EdgeInsets.all(15),
                        height: 120,
                        color: Theme.of(context).colorScheme.tertiary,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  '${AppLocalizations.of(context)!.number} *',
                                  style: GoogleFonts.inriaSans(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18,
                                      color: Theme.of(context)
                                          .colorScheme
                                          .onTertiary),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(right: 0),
                                  child: SizedBox(
                                    width:
                                        MediaQuery.of(context).size.width / 1.5,
                                    height: 60,
                                    child: TextField(
                                      focusNode: numberFocusnode,
                                      keyboardType: TextInputType.number,
                                      onSubmitted: (value) {
                                        value.characters.length == 11
                                            ? {
                                                Database().getUserNumber(),
                                                Database()
                                                    .updateUserNumber(value)
                                              }
                                            : showTopSnackBar(
                                                Overlay.of(context)!,
                                                CustomSnackBar.error(
                                                    message:
                                                        AppLocalizations.of(
                                                                context)!
                                                            .invalidPhoneNumber,
                                                    textStyle:
                                                        GoogleFonts.inriaSans(
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            color: Theme.of(
                                                                    context)
                                                                .colorScheme
                                                                .onSecondary),
                                                    icon: const Icon(
                                                      Bootstrap.x_circle,
                                                      size: 70,
                                                      color: Color.fromARGB(
                                                          56, 0, 0, 0),
                                                    )),
                                                onTap: () {},
                                                displayDuration: const Duration(
                                                    milliseconds: 2000));
                                      },
                                      onChanged: (value) {
                                        Database().getUserNumber();
                                      },
                                      controller: TextEditingController(
                                          text: userNumberModelString
                                              ?.toString()),
                                      textAlign: TextAlign.start,
                                      decoration: InputDecoration(
                                          prefixText:
                                              userNumberModelString == null
                                                  ? ''
                                                  : '+55 ',
                                          prefixStyle: TextStyle(
                                              color: Theme.of(context)
                                                  .colorScheme
                                                  .primary),
                                          hintText:
                                              AppLocalizations.of(context)!
                                                  .addANumber,
                                          contentPadding:
                                              const EdgeInsets.symmetric(
                                                  vertical: 10),
                                          border: const OutlineInputBorder(
                                              borderSide: BorderSide.none)),
                                      maxLines: 1,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            IconButton(
                                onPressed: () {
                                  numberFocusnode.requestFocus();
                                },
                                icon: const Icon(Icons.edit))
                          ],
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 25),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(15),
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width,
                        height: 60,
                        child: ElevatedButton.icon(
                            onPressed: () {
                              showModalBottomSheet(
                                context: context,
                                builder: (context) => Container(
                                  color:
                                      Theme.of(context).colorScheme.secondary,
                                  height:
                                      MediaQuery.of(context).size.height / 7,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      Text(
                                        AppLocalizations.of(context)!
                                            .areYouSureYouWantToLogOut,
                                        style: GoogleFonts.inriaSans(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 18),
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Container(
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(15),
                                                border: Border.all(
                                                    color: Theme.of(context)
                                                        .colorScheme
                                                        .primary)),
                                            height: 50,
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width /
                                                2.5,
                                            child: MaterialButton(
                                                onPressed: () {
                                                  Navigator.pop(context);
                                                },
                                                child: Text(
                                                  AppLocalizations.of(context)!
                                                      .no,
                                                  style: TextStyle(
                                                      color: Theme.of(context)
                                                          .colorScheme
                                                          .primary),
                                                )),
                                          ),
                                          const SizedBox(
                                            width: 15,
                                          ),
                                          ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(15),
                                            child: SizedBox(
                                              height: 50,
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width /
                                                  2.5,
                                              child: MaterialButton(
                                                  color: Colors.red,
                                                  onPressed: () async {
                                                    Future signOut() async {
                                                      context
                                                          .read<AppBloc>()
                                                          .add(
                                                              AppEventSignOut());
                                                    }

                                                    await signOut();
                                                    // ignore: use_build_context_synchronously
                                                    Navigator.pop(context);
                                                  },
                                                  child: Text(
                                                    AppLocalizations.of(
                                                            context)!
                                                        .yes,
                                                    style: const TextStyle(
                                                        color: Colors.white),
                                                  )),
                                            ),
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              );
                            },
                            icon: const Icon(Icons.logout),
                            label: Text(AppLocalizations.of(context)!.logOut)),
                      ),
                    ),
                  ),
                  Text(
                    'Fale conosco',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).colorScheme.onTertiary),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextButton.icon(
                      onPressed: () async {
                        final url = Uri.parse(
                            'https://api.whatsapp.com/send/?phone=%2B5511988075450&text&type=phone_number&app_absent=0');
                        if (await canLaunchUrl(url)) {
                          await launchUrl(url,
                              mode: LaunchMode.externalApplication);
                        }
                      },
                      icon: Logo(
                        Logos.whatsapp,
                        size: 19,
                      ),
                      label: const Text('Whatsapp')),
                  TextButton.icon(
                      onPressed: () async {
                        const toEmail = 'blacbeardburguer@gmail.com';
                        const subject = 'Fale conosco app';
                        final url =
                            Uri.parse('mailto:$toEmail?subject=$subject');
                        if (await canLaunchUrl(url)) {
                          await launchUrl(url);
                        }
                      },
                      icon: Logo(
                        Logos.gmail,
                        size: 18,
                      ),
                      label: const Text('blacbeardburguer@gmail.com')),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    'Siga a gente no instagram!',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).colorScheme.onTertiary),
                  ),
                  TextButton.icon(
                      onPressed: () async {
                        final url = Uri.parse(
                            'https://instagram.com/blackbeardburguer?igshid=YmMyMTA2M2Y=');
                        if (await canLaunchUrl(url)) {
                          await launchUrl(url,
                              mode: LaunchMode.externalApplication);
                        }
                      },
                      icon: Logo(
                        Logos.instagram,
                        size: 18,
                      ),
                      label: const Text('@blackbeardburguer')),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
