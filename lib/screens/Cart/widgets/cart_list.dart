import 'package:car_app/blocs/cart_bloc/cart_bloc.dart';
import 'package:car_app/models/adress_model.dart';
import 'package:car_app/models/cart_model.dart';
import 'package:car_app/screens/Adress/complement_adress_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:car_app/models/adress_model.dart';

class CartList extends StatelessWidget {
  const CartList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CartBloc, CartState>(
      builder: (context, event) {
        List<CartModel> cartList = event.cartItems;
        print(cartList);
        return Column(
          children: [
            ListView.builder(
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
                            padding: const EdgeInsets.all(25),
                            color: Theme.of(context).colorScheme.tertiary,
                            child: Row(
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                      width: MediaQuery.of(context).size.width / 2,
                                      child: Text(
                                        '${cartList[index].quantity}x ${cartList[index].name}',
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: GoogleFonts.inriaSans(
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    Text(
                                      cartList[index].observation ??
                                          'Sem observações',
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
                                      'R\$  ${cartList[index].price.toString()}',
                                      style: const TextStyle(
                                          color: Colors.green,
                                          fontWeight: FontWeight.bold),
                                    )
                                  ],
                                ),
                                const Spacer(),
                                ClipRRect(
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
                              ],
                            )),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 15),
                        child: ClipRRect(
                            borderRadius: BorderRadius.circular(15),
                            child: Container(
                              height: 50,
                              color: Theme.of(context).colorScheme.tertiary,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: [
                                  IconButton(
                                      onPressed: () {},
                                      icon: Icon(Icons.add)),
                                  IconButton(
                                      onPressed: () {},
                                      icon: Icon(Icons.remove)),
                                  IconButton(
                                      onPressed: () {},
                                      icon: Icon(Icons.delete_forever))
                                ],
                              ),
                            )),
                      ),
                    ],
                  ),
                );
              },
            ),
            Text('Valor do frete $distanceFromStore')
          ],
        );
      },
    );
  }
}
