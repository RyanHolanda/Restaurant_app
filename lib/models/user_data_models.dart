// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:car_app/firebase/storage/add_user_data.dart';

class AdressModel {
  String? userAdress;
  AdressModel({
    this.userAdress,
  });

  factory AdressModel.fromFirestore(
      DocumentSnapshot<Map<String, dynamic>> snapshot,
      SnapshotOptions? options) {
    final data = snapshot.data();
    return AdressModel(userAdress: data?['adress']);
  }

  Map<String, dynamic> toFirestore() {
    return {if (userAdress != null) "adress": userAdress};
  }
}

class DistanceModel {
  double? distance;
  DistanceModel({
    this.distance,
  });

  factory DistanceModel.fromFirestore(
      DocumentSnapshot<Map<String, dynamic>> snapshot,
      SnapshotOptions? options) {
    final data = snapshot.data();
    return DistanceModel(distance: data?['DistanceFromStore'] ?? 0);
  }
  Map<String, dynamic> toFirestore() {
    // ignore: unnecessary_null_comparison
    return {if (distance != null) "DistanceFromStore": distance};
  }
}

class NameModel {
  String? userName;
  NameModel({
    this.userName,
  });

  factory NameModel.fromFirestore(
      DocumentSnapshot<Map<String, dynamic>> snapshot,
      SnapshotOptions? options) {
    final data = snapshot.data();
    return NameModel(userName: data?['name']);
  }
  Map<String, dynamic> toFirestore() {
    // ignore: unnecessary_null_comparison
    return {if (userName != null) "name": userName};
  }
}

class NumberModel {
  String? userNumber;
  NumberModel({
    this.userNumber,
  });

  factory NumberModel.fromFirestore(
      DocumentSnapshot<Map<String, dynamic>> snapshot,
      SnapshotOptions? options) {
    final data = snapshot.data();
    return NumberModel(userNumber: data?['phone_number']);
  }
  Map<String, dynamic> toFirestore() {
    // ignore: unnecessary_null_comparison
    return {if (userNumber != null) "phone_number": userNumber};
  }
}

class UserOrdersModel {
  String? item;
  double? total;
  String? adress;
  String? date;
  bool? isDelivey;
  String? paymentMethod;
  String? wantSachets;
  String? molhoOrMaionese;
  String? meatPoint;
  String? name;
  bool? cooking;
  bool? orderFinishedCook;
  bool? inDelivery;
  bool? completed;
  int? id;
  UserOrdersModel({
    this.date,
    this.item,
    this.total,
    this.adress,
    this.isDelivey,
    this.paymentMethod,
    this.wantSachets,
    this.molhoOrMaionese,
    this.meatPoint,
    this.name,
    this.cooking,
    this.orderFinishedCook,
    this.inDelivery,
    this.completed,
    this.id,
  });

  factory UserOrdersModel.fromFirestore(
      DocumentSnapshot<Map<String, dynamic>> snapshot,
      SnapshotOptions? options) {
    final data = snapshot.data();
    return UserOrdersModel(
        date: data?['order_date'],
        cooking: data?['cooking'],
        id: data?['order_id'],
        inDelivery: data?['order_in_delivery'],
        isDelivey: data?['is_delivery'],
        meatPoint: data?['meat_point'],
        molhoOrMaionese: data?['molho_ou_maionese'],
        name: data?['client_name'],
        orderFinishedCook: data?['order_finished_cook'],
        paymentMethod: 'payment_method',
        total: data?['order_total_price'],
        wantSachets: data?['sachets'],
        item: data?['item'],
        adress: data?['client_adress'],
        completed: data?['order_completed']);
  }
  Map<String, dynamic> toFirestore() {
    // ignore: unnecessary_null_comparison
    return {
      "order_date": date,
      "is_delivery": isDelivey,
      "meat_point": meatPoint,
      "sachets": wantSachets,
      "molho_ou_maionese": molhoOrMaionese,
      "item": item,
      "order_id": id,
      "client_name": name,
      "client_adress": adress,
      "payment_method": paymentMethod,
      "cooking": cooking,
      "order_finished_cook": orderFinishedCook,
      "order_in_delivery": inDelivery,
      "order_completed": completed,
      "order_total_price": total,
    };
  }
}

List<UserOrdersModel> userOrdersID = [];
String? userNumberModelString;
String? userNameString;
double? distanceFromStore;
String? userAdressModelString;
