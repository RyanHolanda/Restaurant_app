import 'package:car_app/NavBar/bottom_nav_bar.dart';
import 'package:car_app/blocs/cart_bloc/cart_bloc.dart';
import 'package:car_app/blocs/order_bloc/order_bloc.dart';
import 'package:car_app/models/cart_model.dart';
import 'package:car_app/models/user_data_models.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:car_app/screens/Home/home.dart';
import 'package:car_app/screens/Orders/orders_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:page_transition/page_transition.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ApprovedPaymentScreen extends StatefulWidget {
  ApprovedPaymentScreen({
    required this.isDelivery,
    required this.meatPoint,
    required this.molhoOrMaionese,
    required this.wantSachets,
    required this.total,
    required this.paymentMethod,
    Key? key,
  }) : super(key: key);

  String paymentMethod;
  double total;
  bool isDelivery;
  String meatPoint;
  String wantSachets;
  String molhoOrMaionese;

  @override
  State<ApprovedPaymentScreen> createState() => _ApprovedPaymentScreenState();
}

class _ApprovedPaymentScreenState extends State<ApprovedPaymentScreen>
    with TickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        body: Center(
            child: Lottie.asset(
          'assets/approved_payment.json',
          height: 300,
          controller: _controller,
          onLoaded: (composition) {
            _controller
              ..duration = composition.duration
              ..forward().whenComplete(() => Navigator.push(
                  context,
                  PageTransition(
                      child: ReceiptScreen(
                          isDelivery: widget.isDelivery,
                          meatPoint: widget.meatPoint,
                          molhoOrMaionese: widget.molhoOrMaionese,
                          wantSachets: widget.wantSachets,
                          total: widget.total,
                          paymentMethod: widget.paymentMethod),
                      type: PageTransitionType.fade)));
          },
        )),
      ),
    );
  }
}

class ReceiptScreen extends StatelessWidget {
  ReceiptScreen(
      {super.key,
      required this.isDelivery,
      required this.total,
      required this.paymentMethod,
      required this.meatPoint,
      required this.molhoOrMaionese,
      required this.wantSachets});

  double total;
  String meatPoint;
  String wantSachets;
  bool isDelivery;
  String molhoOrMaionese;
  String paymentMethod;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CartBloc, CartState>(
      builder: (context, event) {
        List<CartModel> itemsOrdered = event.cartItems;
        final itemsOrderedToList = itemsOrdered
            .map((value) => '${value.quantity}x ${value.name}')
            .toList();
        print(itemsOrderedToList.toString());
        context.read<OrderBloc>().add(OrderEventSendOrderToProduction(
            isDelivery: isDelivery,
            meatPoint: meatPoint,
            molhoOrMaionese: molhoOrMaionese,
            wantSachets: wantSachets,
            item: itemsOrderedToList.toString(),
            total: total,
            adress: userAdressModelString!,
            paymentMethod: paymentMethod,
            name: userNameString!,
            cooking: false,
            orderFinishedCook: false,
            inDelivery: false,
            completed: false,
            id: DateTime.now().microsecondsSinceEpoch));
        return WillPopScope(
          onWillPop: () async => false,
          child: Scaffold(
            bottomNavigationBar: SafeArea(
              child: Container(
                height: 60,
                color: Theme.of(context).colorScheme.primary,
                child: ElevatedButton.icon(
                  onPressed: () {
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => MyBottomNav(
                            selectedIndex: 1,
                          ),
                        ));
                  },
                  icon: const Icon(Icons.check),
                  label: Text(AppLocalizations.of(context)!.continuee),
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(
                          Theme.of(context).colorScheme.primary)),
                ),
              ),
            ),
            body: Padding(
              padding: const EdgeInsets.all(15),
              child: SafeArea(
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        AppLocalizations.of(context)!.orderApproved,
                        style: GoogleFonts.urbanist(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      Lottie.asset('assets/dancing_monkey.json', height: 250),
                      Padding(
                        padding: const EdgeInsets.only(top: 25),
                        child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              AppLocalizations.of(context)!.cart,
                              style: GoogleFonts.inriaSans(
                                  color:
                                      Theme.of(context).colorScheme.onTertiary,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16),
                            )),
                      ),
                      Expanded(
                        child: ListView.builder(
                            physics: const BouncingScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: itemsOrdered.length,
                            itemBuilder: (context, index) => Padding(
                                  padding: const EdgeInsets.only(
                                      bottom: 10, top: 10),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(15),
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 15),
                                      color: Theme.of(context)
                                          .colorScheme
                                          .tertiary,
                                      height: 70,
                                      width: MediaQuery.of(context).size.width /
                                          1.2,
                                      child: Row(
                                        children: [
                                          Align(
                                              alignment: Alignment.centerLeft,
                                              child: SizedBox(
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width /
                                                      1.5,
                                                  child: Text(
                                                    itemsOrdered[index].name,
                                                    maxLines: 1,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    style: const TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ))),
                                          const Spacer(),
                                          Text(
                                            '${itemsOrdered[index].quantity}x',
                                            style: const TextStyle(
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                )),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
