import 'dart:convert';

import 'package:http/http.dart' as http;

class SendOrderToProduction {
  String url = 'https://black-beard-burguer-406f0.web.app/create/orders';
  String item;
  double total;
  String adress;
  String clientNumber;
  bool isDelivey;
  String paymentMethod;
  String wantSachets;
  String molhoOrMaionese;
  String meatPoint;
  String name;
  String date;
  bool cooking;
  bool orderFinishedCook;
  bool inDelivery;
  String clientPIXKey;
  bool completed;
  String howMuchGonnaPay;
  int id;

  SendOrderToProduction(
      {required this.paymentMethod,
      required this.clientNumber,
      required this.isDelivey,
      required this.wantSachets,
      required this.molhoOrMaionese,
      required this.howMuchGonnaPay,
      required this.meatPoint,
      required this.orderFinishedCook,
      required this.inDelivery,
      required this.completed,
      required this.date,
      required this.cooking,
      required this.id,
      required this.name,
      required this.adress,
      required this.item,
      required this.clientPIXKey,
      required this.total});

  Future sendOrderToProduction() async {
    try {
      await http.post(Uri.parse(url),
          body: json.encode({
            "client_number": clientNumber,
            "date": date,
            "is_delivery": isDelivey,
            "order_date": date,
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
            "client_pix_key": clientPIXKey,
            "client_will_pay": howMuchGonnaPay
          }),
          headers: _setHeaders());
    } catch (e) {}
  }
}

_setHeaders() => {
      'Content-type': 'application/json',
      'accept': 'application/json',
    };
