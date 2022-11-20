// ignore_for_file: public_member_api_docs, sort_constructors_first
class ItemModel {
  final String id;
  final String name;
  final String description;
  final String price;
  final String image;
  final int orders;
  final bool paused;
  ItemModel({
    required this.orders,
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.image,
    required this.paused,
  });

  factory ItemModel.fromJson(Map<String, dynamic> json) {
    return ItemModel(
        orders: json['orders'] ?? 0,
        id: json['id'],
        name: json['name'] ?? 'Nome indefinido',
        description: json['description'] ?? 'Descrição indefinida',
        price: json['price'] ?? 'Preço indefinido',
        image: json['image'] ??
            'https://media.istockphoto.com/id/1366463174/vector/burger-hand-drawing-sketch-engraving-illustration-style.jpg?b=1&s=612x612&w=0&k=20&c=st8lSrhHmc6Lz_tshsnrt_9TG2R00FxuPWWbJFs98xI=',
        paused: json['paused']);
  }
}

List<ItemModel> itemsList = [];
