// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class ChangeScreen extends StatelessWidget {
  const ChangeScreen({
    Key? key,
    required this.paymentMethod,
    required this.total,
    required this.meatPoint,
    required this.wantSachets,
    required this.molhoOrMaionese,
    required this.isDelivery,
    required this.payymentMethodID,
  }) : super(key: key);

  final String paymentMethod;
  final double total;
  final String meatPoint;
  final String wantSachets;
  final String molhoOrMaionese;
  final bool isDelivery;
  final String payymentMethodID;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: IconThemeData(color: Theme.of(context).colorScheme.primary),
      ),
    );
  }
}

// ApprovedPaymentScreen(
//                                                       isDelivery:
//                                                           widget.isDelivery,
//                                                       meatPoint:
//                                                           widget.meatPoint,
//                                                       molhoOrMaionese: widget
//                                                           .molhoOrMaionese,
//                                                       wantSachets:
//                                                           widget.wantSachets,
//                                                       total: widget.total,
//                                                       paymentMethod: widget
//                                                           .payymentMethodID),