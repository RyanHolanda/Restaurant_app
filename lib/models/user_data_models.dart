// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cloud_firestore/cloud_firestore.dart';

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

String? userNumberModelString;
String? userNameString;
double? distanceFromStore;
String? userAdressModelString;
