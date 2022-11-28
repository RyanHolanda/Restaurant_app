import 'package:car_app/models/user_data_models.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../auth/auth.dart';

class Database {
  final user = Auth().currentUser;

  Future addUserNumber(phone) async {
    final user = Auth().currentUser;
    FirebaseFirestore.instance.collection('Users').doc(user!.email).set({
      'phone_number': phone,
    });
  }

  Future addUserAdress(adress, distance) async {
    FirebaseFirestore.instance.collection('Users').doc(user!.email).update(
        {'adress': adress, 'DistanceFromStore': distance}).catchError((err) {
      if (err.code == 'not-found') {
        FirebaseFirestore.instance
            .collection('Users')
            .doc(user!.email)
            .set({'adress': adress, 'DistanceFromStore': distance});
      }
    });
  }

  Future addUserName(name) async {
    FirebaseFirestore.instance
        .collection('Users')
        .doc(user!.email)
        .update({'name': name}).catchError((err) {
      if (err.code == 'not-found') {
        FirebaseFirestore.instance
            .collection('Users')
            .doc(user!.email)
            .set({'name': name});
      }
    });
  }

  Future updateUserNumber(phone) async {
    FirebaseFirestore.instance
        .collection('Users')
        .doc(user!.email)
        .update({'phone_number': phone}).catchError((err) {
      if (err.code == 'not-found') {
        FirebaseFirestore.instance
            .collection('Users')
            .doc(user!.email)
            .set({'phone_number': phone});
      }
    });
  }

  Future getUserName() async {
    final ref = FirebaseFirestore.instance
        .collection('Users')
        .doc(user!.email)
        .withConverter(
            fromFirestore: NameModel.fromFirestore,
            toFirestore: (NameModel userName, _) => NameModel().toFirestore());
    final docSnap = await ref.get();
    final userName = docSnap.data();
    if (userName != null) {
      userNameString = userName.userName;
    } else {
      userNameString = null;
    }
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

  Future getUserDistance() async {
    final ref = FirebaseFirestore.instance
        .collection('Users')
        .doc(user!.email)
        .withConverter(
            fromFirestore: DistanceModel.fromFirestore,
            toFirestore: (DistanceModel distance, _) =>
                DistanceModel().toFirestore());
    final docSnap = await ref.get();
    final distance = docSnap.data();
    if (distance != null) {
      distanceFromStore = distance.distance;
    } else {
      distanceFromStore = null;
      getUserDistance();
    }
  }

  Future getUserNumber() async {
    final ref = FirebaseFirestore.instance
        .collection('Users')
        .doc(user!.email)
        .withConverter(
            fromFirestore: NumberModel.fromFirestore,
            toFirestore: (NumberModel userNumber, _) =>
                NumberModel().toFirestore());
    final docSnap = await ref.get();
    final userNumber = docSnap.data();
    if (userNumber != null) {
      userNumberModelString = userNumber.userNumber;
    } else {
      userAdressModelString = null;
    }
  }

  Future getAllData() async {
    await getUserNumber();
    await getUserAdress();
    await getUserDistance();
    await getUserName();
  }
}
