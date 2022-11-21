import 'package:car_app/firebase/storage/storage_error.dart';
import 'package:car_app/models/adress_model.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../auth/auth.dart';

class Database {
  final user = Auth().currentUser;

  Future addUserNumber(phone) async {
    final user = Auth().currentUser;
    FirebaseFirestore.instance.collection('Users').doc(user!.email).set({
      'phone_number': phone,
    });
    print('Added');
  }

  Future addUserAdress(adress) async {
    FirebaseFirestore.instance
        .collection('Users')
        .doc(user!.email)
        .update({'adress': adress});
  }

  printUserAdress() async {
    final ref = FirebaseFirestore.instance
        .collection('Users')
        .doc(user!.email)
        .withConverter(
            fromFirestore: AdressModel.fromFirestore,
            toFirestore: (AdressModel userAdress, _) =>
                AdressModel().toFirestore());
    final docSnap = await ref.get();
    final userAdress = docSnap.data();
    if (userAdress != null) {
      print(userAdress.userAdress);
    } else {
      print('No such document');
    }
  }
}
