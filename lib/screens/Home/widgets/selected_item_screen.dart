import 'package:car_app/blocs/cart_bloc/cart_bloc.dart';
import 'package:car_app/models/cart_model.dart';
import 'package:car_app/screens/Cart/cart_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:page_transition/page_transition.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

class SelectedItemScreen extends StatefulWidget {
  const SelectedItemScreen(
      {super.key,
      required this.homeState,
      required this.paused,
      required this.price,
      required this.imageUrl,
      required this.name,
      required this.description});

  final String imageUrl;
  final String name;
  final String description;
  final bool paused;
  final String homeState;
  final double price;

  @override
  State<SelectedItemScreen> createState() => _SelectedItemScreenState();
}

class _SelectedItemScreenState extends State<SelectedItemScreen> {
  int quantity = 1;
  var newPrice = 0.0;
  TextEditingController observationsController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    var item = CartModel(
        observations: observationsController.text == ''
            ? null
            : observationsController.text,
        name: widget.name,
        imageUrl: widget.imageUrl,
        price: newPrice == 0 ? widget.price : newPrice,
        quantity: quantity);
    return BlocBuilder<CartBloc, CartState>(
      builder: (context, state) {
        return GestureDetector(
          onHorizontalDragUpdate: (details) {
            if (details.primaryDelta! > 50) {
              Navigator.pop(context);
            }
          },
          onTap: () => FocusScope.of(context).unfocus(),
          child: Scaffold(
            bottomNavigationBar: SafeArea(
              child: ClipRRect(
                borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(15),
                    topRight: Radius.circular(15)),
                child: Container(
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.secondaryContainer,
                  ),
                  padding: const EdgeInsets.all(15),
                  height: 100,
                  child: widget.paused
                      ? Center(
                          child: Text(
                          AppLocalizations.of(context)!.unavailableItem,
                          style: GoogleFonts.inriaSans(
                              color: Theme.of(context).colorScheme.onTertiary,
                              fontWeight: FontWeight.bold),
                        ))
                      : Row(
                          children: [
                            IconButton(
                              onPressed: () {
                                quantity == 1
                                    ? null
                                    : setState(() {
                                        quantity--;
                                        newPrice = widget.price * quantity;
                                      });
                              },
                              icon: const Icon(Icons.remove),
                              color: quantity == 1
                                  ? Colors.grey.shade400
                                  : Theme.of(context).colorScheme.primary,
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Text(
                              quantity.toString(),
                              style: GoogleFonts.inriaSans(
                                  fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            IconButton(
                              onPressed: () {
                                setState(() {
                                  quantity++;
                                  newPrice = widget.price * quantity;
                                });
                              },
                              icon: const Icon(Icons.add),
                            ),
                            const Spacer(),
                            ClipRRect(
                              borderRadius: BorderRadius.circular(15),
                              child: SizedBox(
                                height: 50,
                                child: ElevatedButton(
                                  onPressed: () {
                                    context
                                        .read<CartBloc>()
                                        .add(AddItemToCart(item: item));
                                    showTopSnackBar(
                                        Overlay.of(context)!,
                                        CustomSnackBar.success(
                                            message:
                                                AppLocalizations.of(context)!
                                                    .itemAddedtoCart,
                                            textStyle: GoogleFonts.inriaSans(
                                                fontWeight: FontWeight.bold,
                                                color: Theme.of(context)
                                                    .colorScheme
                                                    .onSecondary),
                                            icon: const Icon(
                                              Bootstrap.cart3,
                                              size: 70,
                                              color:
                                                  Color.fromARGB(56, 0, 0, 0),
                                            )), onTap: () {
                                      Navigator.push(
                                          context,
                                          PageTransition(
                                              child: const CartScreen(),
                                              type: PageTransitionType
                                                  .rightToLeftWithFade));
                                    },
                                        displayDuration:
                                            const Duration(milliseconds: 500));
                                  },
                                  child: Text(newPrice.toString() == '0.0'
                                      ? '${AppLocalizations.of(context)!.add}   R\$ ${widget.price}'
                                      : '${AppLocalizations.of(context)!.add}   R\$ ${newPrice.toStringAsFixed(2).toString()}'),
                                ),
                              ),
                            )
                          ],
                        ),
                ),
              ),
            ),
            extendBodyBehindAppBar: true,
            appBar: AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0,
              iconTheme: const IconThemeData(color: Colors.white),
            ),
            body: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Align(
                    alignment: Alignment.center,
                    child: ClipRRect(
                      borderRadius: const BorderRadius.only(
                          bottomLeft: Radius.circular(0),
                          bottomRight: Radius.circular(55)),
                      child: Image.network(
                        widget.imageUrl,
                        width: MediaQuery.of(context).size.width / 1,
                        height: MediaQuery.of(context).size.height / 2.5,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 15, top: 20, right: 15),
                    child: Text(
                      widget.name,
                      style: GoogleFonts.inriaSans(
                          fontWeight: FontWeight.bold, fontSize: 30),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 15, top: 6, right: 15),
                    child: Text(
                      widget.description,
                      style: GoogleFonts.inriaSans(
                          color: Theme.of(context).colorScheme.onTertiary,
                          fontWeight: FontWeight.normal,
                          fontSize: 18),
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 15, top: 25, right: 15),
                    child: Text(
                      'R\$ ${widget.price}',
                      style: GoogleFonts.inriaSans(
                        color: Colors.green,
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 30, horizontal: 15),
                    child: TextField(
                      onChanged: (value) => setState(() {
                        observationsController.text = value;
                      }),
                      decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                              borderSide: BorderSide(
                                  color:
                                      Theme.of(context).colorScheme.tertiary)),
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                              borderSide: BorderSide(
                                  color:
                                      Theme.of(context).colorScheme.primary)),
                          label: Text(AppLocalizations.of(context)!.addANote)),
                    ),
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
