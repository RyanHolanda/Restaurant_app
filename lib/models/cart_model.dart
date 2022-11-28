
// ignore_for_file: public_member_api_docs, sort_constructors_first
class CartModel {
  String name;
  double price;
  int quantity;
  String? observations;
  String imageUrl;
  CartModel({
    required this.quantity,
    required this.name,
    required this.price,
    this.observations,
    required this.imageUrl,
  });

  CartModel copyWith({
    String? name,
    int? quantity,
    double? price,
    String? observations,
    String? imageUrl,
  }) {
    return CartModel(
      quantity: quantity ?? this.quantity,
      name: name ?? this.name,
      price: price ?? this.price,
      observations: observations ?? this.observations,
      imageUrl: imageUrl ?? this.imageUrl,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'quantity': quantity,
      'price': price,
      'observations': observations,
      'imageUrl': imageUrl,
    };
  }

  factory CartModel.fromMap(Map<String, dynamic> map) {
    return CartModel(
      quantity: map['quantity'] as int,
      name: map['name'] as String,
      price: map['price'] as double,
      observations: map['observations'] as String,
      imageUrl: map['imageUrl'] as String,
    );
  }
}
