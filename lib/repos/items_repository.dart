import 'dart:convert';

import 'package:car_app/models/items_model.dart';
import 'package:http/http.dart' as http;

class ItemsRepository {
  String url = 'https://blackbeard-api.herokuapp.com/items';
  Future<List<ItemModel>> getItems() async {
    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final List result = json.decode(utf8.decode(response.bodyBytes));
        return result.map(((e) => ItemModel.fromJson(e))).toList();
      } else {
        throw Exception(response.reasonPhrase);
      }
    } catch (e) {
      print(e);
      print('trying to reconnect items');

      return ItemsRepository().getItems();
    }
  }
}
