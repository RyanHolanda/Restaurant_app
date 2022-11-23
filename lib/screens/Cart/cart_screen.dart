import 'package:car_app/blocs/cart_bloc/cart_bloc.dart';
import 'package:car_app/blocs/home_bloc/home_bloc.dart';
import 'package:car_app/models/cart_model.dart';
import 'package:car_app/screens/Cart/widgets/cart_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:icons_plus/icons_plus.dart';

class CartScreen extends StatelessWidget {
  CartScreen({super.key, required this.homeState});
  String homeState;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CartBloc, CartState>(
      builder: (context, event) {
        return Scaffold(
          bottomNavigationBar: Padding(
            padding: const EdgeInsets.all(20),
            child: ClipRRect(
                borderRadius: BorderRadius.circular(0),
                child: ElevatedButton.icon(
                    onPressed: () {},
                    icon: const Icon(Bootstrap.check),
                    label: const Text('Finalizar compra'))),
          ),
          appBar: AppBar(
            title: Text(
              'Carrinho',
              style: GoogleFonts.inriaSans(
                  color: Theme.of(context).colorScheme.primary,
                  fontWeight: FontWeight.bold),
            ),
            backgroundColor: Theme.of(context).colorScheme.secondary,
            elevation: 0,
            iconTheme:
                IconThemeData(color: Theme.of(context).colorScheme.primary),
            actions: [
              Padding(
                padding: const EdgeInsets.all(15),
                child: Text(
                  homeState == 'Delivery'
                      ? AppLocalizations.of(context)!.delivery
                      : AppLocalizations.of(context)!.pickUp,
                  style: GoogleFonts.inriaSans(
                      color: Theme.of(context).colorScheme.primary),
                ),
              ),
            ],
          ),
          body: CartList(),
        );
      },
    );
  }
}
