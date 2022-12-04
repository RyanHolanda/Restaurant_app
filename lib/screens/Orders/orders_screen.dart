import 'package:car_app/firebase/storage/add_user_data.dart';
import 'package:car_app/models/user_data_models.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
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

class OrdersList extends StatelessWidget {
  const OrdersList({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ListView.builder(
          itemCount: userOrdersID.length,
          shrinkWrap: true,
          itemBuilder: (BuildContext context, int index) {
            return Text(userOrdersID[index].date.toString());
          },
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
