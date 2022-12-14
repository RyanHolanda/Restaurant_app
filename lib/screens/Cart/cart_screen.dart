import 'package:car_app/blocs/cart_bloc/cart_bloc.dart';
import 'package:car_app/blocs/home_bloc/home_bloc.dart';
import 'package:car_app/models/store_status_model.dart';
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
  const CartScreen({super.key});

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
                bottomNavigationBar: SafeArea(
                  child: BlocBuilder<HomeBloc, HomeState>(
                    builder: (context, state) {
                      return FinishOrderWidget(
                          storeStatus: storeStatus[0].storeStatus,
                          shippingPrice: shippingPrice,
                          total: state is HomeStateDelivery ? total! : sum);
                    },
                  ),
                ),
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
                        child: BlocBuilder<HomeBloc, HomeState>(
                          builder: (context, state) {
                            return Text(
                              state is HomeStateDelivery
                                  ? AppLocalizations.of(context)!.delivery
                                  : AppLocalizations.of(context)!.pickUp,
                              style: GoogleFonts.inriaSans(
                                  color: Theme.of(context).colorScheme.primary,
                                  fontWeight: FontWeight.bold),
                            );
                          },
                        ),
                      ),
                    ),
                  ],
                ),
                body: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Column(
                    children: const [
                      CartList(),
                    ],
                  ),
                ),
              );
      },
    );
  }
}

class FinishOrderWidget extends StatelessWidget {
  const FinishOrderWidget({
    Key? key,
    required this.storeStatus,
    required this.shippingPrice,
    required this.total,
  }) : super(key: key);

  final double shippingPrice;
  final double total;
  final String storeStatus;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
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
                        state is HomeStateDelivery
                            ? Text(
                                '${AppLocalizations.of(context)!.shipping} R\$ ${shippingPrice.toStringAsFixed(2).replaceAll(".", ",")}',
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold),
                              )
                            : const SizedBox.shrink(),
                        const Spacer(),
                        Text(
                          'Total : R\$ ${total.toStringAsFixed(2).replaceAll('.', ',')}',
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
                            if (storeStatus == 'Abrir loja') {
                              showModalBottomSheet(
                                context: context,
                                builder: (context) => Container(
                                  color:
                                      Theme.of(context).colorScheme.secondary,
                                  height:
                                      MediaQuery.of(context).size.height / 5,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(25),
                                        child: Text(
                                          AppLocalizations.of(context)!
                                              .weAreClosed,
                                          style: GoogleFonts.inriaSans(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 18),
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 15,
                                      ),
                                      ClipRRect(
                                        borderRadius: BorderRadius.circular(15),
                                        child: TextButton(
                                            onPressed: () async {
                                              Navigator.pop(context);
                                            },
                                            child: const Text(
                                              'Ok',
                                              style: TextStyle(
                                                  color: Colors.white),
                                            )),
                                      )
                                    ],
                                  ),
                                ),
                              );
                            } else {
                              Navigator.push(
                                  context,
                                  PageTransition(
                                      child: FinishOrderScreen(
                                        shippingPrice:
                                            state is HomeStateDelivery
                                                ? shippingPrice
                                                : 0,
                                        total: total,
                                      ),
                                      type: PageTransitionType.bottomToTop));
                            }
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
                                    color: Theme.of(context)
                                        .colorScheme
                                        .secondary),
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
      },
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
