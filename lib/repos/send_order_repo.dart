import 'dart:convert';

import 'package:car_app/models/cart_model.dart';
import 'package:http/http.dart' as http;

class SendOrderToProduction {
  String url = 'https://black-beard-burguer-406f0.web.app/create/orders';
  String item;
  double total;
  String adress;
  bool isDelivey;
  String paymentMethod;
  String wantSachets;
  String molhoOrMaionese;
  String meatPoint;
  String name;
  bool cooking;
  bool orderFinishedCook;
  bool inDelivery;
  bool completed;
  int id;

  SendOrderToProduction(
      {required this.paymentMethod,
      required this.isDelivey,
      required this.wantSachets,
      required this.molhoOrMaionese,
      required this.meatPoint,
      required this.orderFinishedCook,
      required this.inDelivery,
      required this.completed,
      required this.cooking,
      required this.id,
      required this.name,
      required this.adress,
      required this.item,
      required this.total});

  Future sendOrderToProduction() async {
    try {
      await http.post(Uri.parse(url),
          body: json.encode({
            "is_delivery": isDelivey,
            "meat_point": meatPoint,
            "sachets": wantSachets,
            "molho_ou_maionese": molhoOrMaionese,
            "item": item.toString(),
            "order_id": id,
            "client_name": name,
            "client_adress": adress,
            "payment_method": paymentMethod,
            "cooking": cooking,
            "order_finished_cook": orderFinishedCook,
            "order_in_delivery": inDelivery,
            "order_completed": completed,
            "order_total_price": total,
          }),
          headers: _setHeaders());
    } catch (e) {
      print('erro aqui mano');
      print(e);
    }
  }
}

_setHeaders() => {
      'Content-type': 'application/json',
      'accept': 'application/json',
    };
