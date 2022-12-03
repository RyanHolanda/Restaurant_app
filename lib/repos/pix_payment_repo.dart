import 'dart:convert';
import 'package:car_app/models/pix_payment_info_model.dart';
import 'package:http/http.dart' as http;

class CreatePixToPay {
  CreatePixToPay({
    required this.transactionAmount,
    required this.email,
  });
  double transactionAmount;
  String email;
  Future<GetPixPaymentId> createPixToPay() async {
    try {
      final response =
          await http.post(Uri.parse('https://api.mercadopago.com/v1/payments'),
              body: json.encode({
                "transaction_amount": 0.01,
                "payment_method_id": "pix",
                "payer": {
                  "email": email,
                },
                "description": "Pagamento via PIX a Black Beard Burguer",
              }),
              headers: _setHeaders());

      final result = json.decode(utf8.decode(response.bodyBytes));
      final test = Map<String, dynamic>.from(result);
      return GetPixPaymentId(id: test['id']);
    } catch (e) {
      print(e);
      return createPixToPay();
    }
  }
}

class GetPixData {
  GetPixData({required this.id});
  int id;
  late String url = 'https://api.mercadopago.com/v1/payments/$id';
  Future<GetPixInfoModel> getPixInfo() async {
    try {
      final response = await http.get(Uri.parse(url), headers: _setHeaders());
      if (response.statusCode == 200) {
        final result = json.decode(response.body);
        final test = Map<String, dynamic>.from(result);
        return GetPixInfoModel(
            id: test['id'],
            transactionAmount: test['transaction_amount'],
            status: test['status'],
            paymentKey: test['point_of_interaction']['transaction_data']
                ['qr_code'],
            qrCodeImage: test['point_of_interaction']['transaction_data']
                ['qr_code_base64']);
      } else {
        throw Exception(response.reasonPhrase);
      }
    } catch (e) {
      print(e);
      return getPixInfo();
    }
  }
}

_setHeaders() => {
      'Content-type': 'application/json',
      'accept': 'application/json',
      'authorization': productionKey
    };

String productionKey =
    'Bearer APP_USR-1397836893388541-112913-d98c9e794165101674f3a4c34b70db04-294877192';
String testKey =
    'Bearer TEST-1397836893388541-112913-69c1db3a4fb79291d179a2f7c5b53729-294877192';
