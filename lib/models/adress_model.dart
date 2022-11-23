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
    return AdressModel(userAdress: data?['adress'] ?? 'no adress');
  }

  Map<String, dynamic> toFirestore() {
    return {if (userAdress != null) "adress": userAdress};
  }
}

String? userAdressModelString;




