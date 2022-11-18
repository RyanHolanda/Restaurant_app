
import 'package:car_app/blocs/home_bloc/home_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:google_fonts/google_fonts.dart';



class MyAppBar extends StatelessWidget {
  const MyAppBar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        return AppBar(
          title: Align(
            alignment: Alignment.center,
            child: SizedBox(
              width: 200,
              height: 50,
              child: Stack(
                children: [
                  AnimatedAlign(
                    duration: const Duration(milliseconds: 100),
                    alignment: state is HomeStateDelivery
                        ? Alignment.centerLeft
                        : Alignment.centerRight,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(21),
                      child: Container(
                        height: 40,
                        width: 100,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: Padding(
                      padding: const EdgeInsets.only(right: 100),
                      child: TextButton(
                          onPressed: () {
                            if (state is HomeStateDelivery) {
                              null;
                            } else {
                              context
                                  .read<HomeBloc>()
                                  .add(HomeEventGoToDeliverySection());
                            }
                          },
                          child: Text(
                            AppLocalizations.of(context)!.delivery,
                            style: GoogleFonts.inriaSans(
                                fontWeight: FontWeight.bold,
                                color: state is HomeStateDelivery
                                    ? Theme.of(context).colorScheme.secondary
                                    : Theme.of(context).colorScheme.primary),
                          )),
                    ),
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 100),
                      child: TextButton(
                          onPressed: () {
                            if (state is HomeStatePickUp) {
                              null;
                            } else {
                              context
                                  .read<HomeBloc>()
                                  .add(HomeEventGoToPickupSection());
                            }
                          },
                          child: Text(
                            AppLocalizations.of(context)!.pickUp,
                            style: GoogleFonts.inriaSans(
                                fontWeight: FontWeight.bold,
                                color: state is HomeStatePickUp
                                    ? Theme.of(context).colorScheme.secondary
                                    : Theme.of(context).colorScheme.primary),
                          )),
                    ),
                  ),
                ],
              ),
            ),
          ),
          backgroundColor: Theme.of(context).colorScheme.secondary,
          elevation: 0,
          toolbarHeight: 90,
        );
      },
    );
  }
}
