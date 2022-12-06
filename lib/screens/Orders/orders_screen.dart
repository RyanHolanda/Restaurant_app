import 'dart:async';

import 'package:car_app/firebase/storage/add_user_data.dart';
import 'package:car_app/models/user_data_models.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:lottie/lottie.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class OrdersScreen extends StatefulWidget {
  const OrdersScreen({super.key});

  @override
  State<OrdersScreen> createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {
  bool isLoading = true;
  getOrders() async {
    await Database().getUserOrders().whenComplete(() => setState(() {
          isLoading = false;
        }));
  }

  @override
  void initState() {
    getOrders();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return userOrdersID.isEmpty
        ? isLoading == true
            ? const Center(child: CircularProgressIndicator())
            : const NoOrdersScreen()
        : isLoading == true
            ? const Center(child: CircularProgressIndicator())
            : const OrdersList();
  }
}

class OrdersList extends StatefulWidget {
  const OrdersList({
    Key? key,
  }) : super(key: key);

  @override
  State<OrdersList> createState() => _OrdersListState();
}

class _OrdersListState extends State<OrdersList> {
  @override
  Widget build(BuildContext context) {
    final myOrders = userOrdersID.reversed.toList();
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(left: 15, right: 15, top: 15),
          child: Center(
            child: ListView.builder(
              physics: const BouncingScrollPhysics(),
              itemCount: myOrders.length,
              shrinkWrap: true,
              itemBuilder: (BuildContext context, int index) {
                Timer.periodic(const Duration(minutes: 1), (timer) {
                  Database().getUserOrders();
                  setState(() {});
                });
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 15, horizontal: 15),
                      child: Text(myOrders[index].date!),
                    ),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(15),
                      child: Container(
                        padding: const EdgeInsets.all(15),
                        color: Theme.of(context).colorScheme.tertiary,
                        height: 120,
                        width: MediaQuery.of(context).size.width,
                        child: Row(
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  '${AppLocalizations.of(context)!.id} ${myOrders[index].id!.toString()}',
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold),
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 5),
                                  child: Text(myOrders[index].isDelivey!
                                      ? AppLocalizations.of(context)!.delivery
                                      : AppLocalizations.of(context)!.pickUp),
                                ),
                                Text(
                                    'R\$ ${myOrders[index].total!.toStringAsFixed(2)}'),
                                const Spacer(),
                                Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 0),
                                  child: Text(
                                    myOrders[index].completed!
                                        ? AppLocalizations.of(context)!
                                            .completed
                                        : myOrders[index].cooking!
                                            ? AppLocalizations.of(context)!
                                                .cooking
                                            : myOrders[index].inDelivery!
                                                ? AppLocalizations.of(context)!
                                                    .inDelivery
                                                : myOrders[index]
                                                        .orderFinishedCook!
                                                    ? AppLocalizations.of(
                                                            context)!
                                                        .finishedCook
                                                    : AppLocalizations.of(
                                                            context)!
                                                        .orderReceived,
                                    style: const TextStyle(
                                        color: Colors.green,
                                        fontWeight: FontWeight.bold),
                                  ),
                                )
                              ],
                            ),
                            const Spacer(),
                            Icon(myOrders[index].completed!
                                ? Icons.check
                                : myOrders[index].inDelivery!
                                    ? Icons.motorcycle
                                    : Icons.alarm)
                          ],
                        ),
                      ),
                    )
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}

class NoOrdersScreen extends StatelessWidget {
  const NoOrdersScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          AppLocalizations.of(context)!.orders,
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
              AppLocalizations.of(context)!.youDontHaveOrders,
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.onTertiary,
                  fontSize: 20),
            ),
            const SizedBox(
              height: 50,
            ),
            Lottie.asset('assets/no_orders.json', height: 300),
            const SizedBox(
              height: 50,
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width / 1.8,
              child: Text(
                AppLocalizations.of(context)!.youDontHaveOrdersDescription,
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
