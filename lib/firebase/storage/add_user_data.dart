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
        .update({'adress': adress}).catchError((err) {
      if (err.code == 'not-found') {
        FirebaseFirestore.instance
            .collection('Users')
            .doc(user!.email)
            .set({'adress': adress});
      }
    });
  }

  Future updateUserNumber(phone) async {
    FirebaseFirestore.instance
        .collection('Users')
        .doc(user!.email)
        .update({'phone': phone}).catchError((err) {
      if (err.code == 'not-found') {
        FirebaseFirestore.instance
            .collection('Users')
            .doc(user!.email)
            .set({'adress': phone});
      }
    });
  }

  Future getUserAdress() async {
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
      userAdressModelString = userAdress.userAdress;
    } else {
      userAdressModelString = null;
      getUserAdress();
    }
  }
}
