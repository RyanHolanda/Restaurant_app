import 'package:car_app/auth/auth.dart';
import 'package:car_app/blocs/home_bloc/home_bloc.dart';
import 'package:car_app/screens/Home/widgets/appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:icons_plus/icons_plus.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeBloc(),
      child: BlocBuilder<HomeBloc, HomeState>(
        builder: (context, state) {
          final user = Auth().currentUser;
          return GestureDetector(
            onTap: () => FocusScope.of(context).unfocus(),
            child: Scaffold(
              appBar: const PreferredSize(
                  preferredSize: Size.fromHeight(100), child: MyAppBar()),
              body: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    LayoutBuilder(builder: (p0, p1) {
                      if (state is HomeStateDelivery) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: GestureDetector(
                            child: SizedBox(
                              child: Row(
                                children: [
                                  const Padding(
                                    padding: EdgeInsets.only(
                                        top: 20, left: 20, right: 20),
                                    child: Icon(FontAwesome.bicycle),
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(top: 20),
                                        child: Text(
                                          AppLocalizations.of(context)!
                                              .receiveYourOrderIn30m1h,
                                          style: GoogleFonts.inriaSans(
                                              color: Theme.of(context)
                                                  .colorScheme
                                                  .onTertiary,
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
                                                color: Theme.of(context)
                                                    .colorScheme
                                                    .primary,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Padding(
                                    padding:
                                        const EdgeInsets.only(top: 20, left: 5),
                                    child: Align(
                                      alignment: Alignment.centerRight,
                                      child: IconButton(
                                          onPressed: () {},
                                          icon: Icon(Icons.navigate_next)),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        );
                      }
                      if (state is HomeStatePickUp) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: GestureDetector(
                            child: SizedBox(
                              child: Row(
                                children: [
                                  const Padding(
                                    padding: EdgeInsets.only(
                                        top: 20, left: 20, right: 20),
                                    child: Icon(FontAwesome.shop),
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(top: 20),
                                        child: Text(
                                          AppLocalizations.of(context)!
                                              .pickUpAdress,
                                          style: GoogleFonts.inriaSans(
                                              color: Theme.of(context)
                                                  .colorScheme
                                                  .onTertiary,
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
                                                color: Theme.of(context)
                                                    .colorScheme
                                                    .primary,
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
                      return SizedBox.shrink();
                    }),
                    Padding(
                      padding:
                          const EdgeInsets.only(top: 50, left: 20, right: 20),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(15),
                        child: SizedBox(
                          width: MediaQuery.of(context).size.width,
                          height: 60,
                          child: TextField(
                            decoration: InputDecoration(
                                suffixIcon: Icon(Icons.search),
                                hintText:
                                    'Brutinho  •  Green Beard  •  Cheddar...',
                                hintStyle: TextStyle(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .onTertiary),
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
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 20, top: 50),
                      child: Text(
                        AppLocalizations.of(context)!.mostordered,
                        style: GoogleFonts.inriaSans(
                            fontWeight: FontWeight.bold, fontSize: 18),
                      ),
                    ),
                    Container(
                      height: 170,
                      child: Padding(
                          padding: const EdgeInsets.only(left: 5, top: 20),
                          child: ListView.builder( 
                            physics: BouncingScrollPhysics(),
                            scrollDirection: Axis.horizontal,
                            itemCount: 3,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 8),
                                child: Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(18),
                                      color: Theme.of(context)
                                          .colorScheme
                                          .onPrimary),
                                  height: 70,
                                  width: 150,
                                  child: Column(
                                    children: const [

                                    ],
                                  ),
                                ),
                              );
                            },
                          )),
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
