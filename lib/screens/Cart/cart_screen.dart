import 'package:car_app/blocs/cart_bloc/cart_bloc.dart';
import 'package:car_app/models/user_data_models.dart';
import 'package:car_app/screens/Finish_Order/finish_order_screen.dart';
import 'package:lottie/lottie.dart';
import 'package:car_app/screens/Cart/widgets/cart_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:page_transition/page_transition.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key, required this.homeState});
  final String homeState;

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  double shippingPrice = 5.00;

  setShippingPrice() {
    if (distanceFromStore! > 3) {
      setState(() {
        shippingPrice = 7.00;
      });
    }

    if (distanceFromStore! > 5) {
      setState(() {
        shippingPrice = 12.00;
      });
    }

    if (distanceFromStore! > 7) {
      setState(() {
        shippingPrice = 16.00;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CartBloc, CartState>(
      builder: (context, event) {
        var list = event.cartItems.map((value) => value.price).toList();
        final sum = list.isEmpty ? null : list.reduce((a, b) => a + b);
        final total = sum == null ? null : sum + shippingPrice;
        return sum == null
            ? const EmptyCartScreen()
            : Scaffold(
                bottomNavigationBar: FinishOrderWidget(
                    homeState: widget.homeState,
                    shippingPrice: shippingPrice,
                    total: total),
                appBar: AppBar(
                  title: Text(
                    AppLocalizations.of(context)!.cart,
                    style: GoogleFonts.inriaSans(
                        color: Theme.of(context).colorScheme.primary,
                        fontWeight: FontWeight.bold),
                  ),
                  backgroundColor: Theme.of(context).colorScheme.secondary,
                  elevation: 0,
                  iconTheme: IconThemeData(
                      color: Theme.of(context).colorScheme.primary),
                  actions: [
                    Center(
                      child: Padding(
                        padding: const EdgeInsets.only(right: 15),
                        child: Text(
                          widget.homeState == 'Delivery'
                              ? AppLocalizations.of(context)!.delivery
                              : AppLocalizations.of(context)!.pickUp,
                          style: GoogleFonts.inriaSans(
                              color: Theme.of(context).colorScheme.primary,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ],
                ),
                body: Column(
                  children: const [
                    CartList(),
                  ],
                ),
              );
      },
    );
  }
}

class FinishOrderWidget extends StatelessWidget {
  const FinishOrderWidget({
    Key? key,
    required this.homeState,
    required this.shippingPrice,
    required this.total,
  }) : super(key: key);

  final double shippingPrice;
  final double? total;
  final String homeState;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: ClipRRect(
          borderRadius: BorderRadius.circular(0),
          child: SizedBox(
            height: 90,
            child: Column(
              children: [
                Row(
                  children: [
                    Text(
                      '${AppLocalizations.of(context)!.shipping} R\$ ${shippingPrice.toStringAsFixed(2).replaceAll(".", ",")}',
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    const Spacer(),
                    Text(
                      'Total : R\$ ${total!.toStringAsFixed(2).replaceAll('.', ',')}',
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    )
                  ],
                ),
                const Spacer(),
                ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: SizedBox(
                    height: 50,
                    child: MaterialButton(
                      color: Theme.of(context).colorScheme.primary,
                      onPressed: () {
                        Navigator.push(
                            context,
                            PageTransition(
                                child: FinishOrderScreen(
                                  shippingPrice: shippingPrice,
                                  total: total,
                                  homeState: homeState,
                                ),
                                type: PageTransitionType.bottomToTop));
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Bootstrap.check,
                            color: Theme.of(context).colorScheme.secondary,
                          ),
                          Text(
                            AppLocalizations.of(context)!.finishMyOrder,
                            style: TextStyle(
                                color: Theme.of(context).colorScheme.secondary),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          )),
    );
  }
}

class EmptyCartScreen extends StatelessWidget {
  const EmptyCartScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          AppLocalizations.of(context)!.cart,
          style: GoogleFonts.inriaSans(
              color: Theme.of(context).colorScheme.primary,
              fontWeight: FontWeight.bold),
        ),
        backgroundColor: Theme.of(context).colorScheme.secondary,
        elevation: 0,
        iconTheme: IconThemeData(color: Theme.of(context).colorScheme.primary),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              AppLocalizations.of(context)!.yourCartIsEmpty,
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.onTertiary,
                  fontSize: 20),
            ),
            const SizedBox(
              height: 50,
            ),
            Lottie.asset('assets/empty_cart_image.json', height: 300),
            const SizedBox(
              height: 50,
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width / 1.8,
              child: Text(
                AppLocalizations.of(context)!.addAFewItemsInYourCart,
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.onTertiary,
                    fontSize: 20),
              ),
            )
          ],
        ),
      ),
    );
  }
}
