import 'dart:convert';

import 'package:car_app/models/store_status_model.dart';
import 'package:http/http.dart' as http;

class StoreStatusRepo {
  String url = 'https://black-beard-burguer-406f0.web.app/storestatus';

  Future<List<StoreStatusModel>> getStoreStatus() async {
    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final List result = json.decode(utf8.decode(response.bodyBytes));
        return result.map(((e) => StoreStatusModel.fromJson(e))).toList();
      } else {
        throw Exception(response.reasonPhrase);
      }
    } catch (e) {
      print('erro store status');
      return StoreStatusRepo().getStoreStatus();
    }
  }
}
