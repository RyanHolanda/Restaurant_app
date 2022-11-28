import 'package:car_app/blocs/cart_bloc/cart_bloc.dart';
import 'package:car_app/models/cart_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class CartList extends StatefulWidget {
  const CartList({Key? key}) : super(key: key);

  @override
  State<CartList> createState() => _CartListState();
}

class _CartListState extends State<CartList> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CartBloc, CartState>(
      builder: (context, event) {
        List<CartModel> cartList = event.cartItems;
        return ListView.builder(
          shrinkWrap: true,
          physics: const BouncingScrollPhysics(),
          itemCount: cartList.length,
          itemBuilder: (BuildContext context, int index) {
            return Padding(
              padding: const EdgeInsets.all(15),
              child: Column(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(15),
                    child: Container(
                        height: 120,
                        padding: const EdgeInsets.only(
                            left: 25, top: 0, bottom: 0, right: 0),
                        color: Theme.of(context).colorScheme.tertiary,
                        child: Row(
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  width: MediaQuery.of(context).size.width / 3,
                                  child: Padding(
                                    padding: const EdgeInsets.only(top: 25),
                                    child: Text(
                                      '${cartList[index].quantity}x ${cartList[index].name}',
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: GoogleFonts.inriaSans(
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ),
                                Text(
                                  cartList[index].observations ??
                                      AppLocalizations.of(context)!
                                          .noObservations,
                                  style: GoogleFonts.inriaSans(
                                      fontWeight: FontWeight.bold,
                                      color: Theme.of(context)
                                          .colorScheme
                                          .onTertiary),
                                ),
                                const SizedBox(
                                  height: 25,
                                ),
                                Text(
                                  'R\$  ${cartList[index].price.toStringAsFixed(2)}',
                                  style: const TextStyle(
                                      color: Colors.green,
                                      fontWeight: FontWeight.bold),
                                )
                              ],
                            ),
                            const Spacer(),
                            Padding(
                              padding: const EdgeInsets.only(right: 15),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(12),
                                child: SizedBox(
                                  height: 70,
                                  width: 70,
                                  child: Image.network(
                                    cartList[index].imageUrl,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            ),
                            ClipRRect(
                              borderRadius: BorderRadius.circular(0),
                              child: Container(
                                height: 150,
                                padding: const EdgeInsets.all(3),
                                color: Colors.red,
                                child: IconButton(
                                    onPressed: () {
                                      context.read<CartBloc>().add(
                                          DeleteItemFromCart(
                                              item: cartList[index]));
                                    },
                                    icon: const InkWell(
                                      enableFeedback: false,
                                      child: Icon(
                                        EvaIcons.trash_outline,
                                        color: Colors.white,
                                      ),
                                    )),
                              ),
                            )
                          ],
                        )),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}
