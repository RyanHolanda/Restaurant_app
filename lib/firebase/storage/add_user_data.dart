// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:car_app/models/user_data_models.dart';

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

  Future getUserOrders() async {
    final ref = FirebaseFirestore.instance
        .collection('Users')
        .doc(user!.email)
        .collection('User_Orders')
        .withConverter(
            fromFirestore: UserOrdersModel.fromFirestore,
            toFirestore: (UserOrdersModel userOrdersModel, _) =>
                UserOrdersModel().toFirestore());
    final docSnap = await ref.get();
    final userOrdersModel = docSnap.docs;
    userOrdersID = userOrdersModel.map((value) => value.data()).toList();
  }

  Future getAllData() async {
    await getUserNumber();
    await getUserAdress();
    await getUserDistance();
    await getUserOrders();
    await getUserName();
  }
}

class UserOrders {
  String item;
  double total;
  String adress;
  String date;
  bool isDelivey;
  String paymentMethod;
  String wantSachets;
  String molhoOrMaionese;
  String meatPoint;
  String name;
  bool cooking;
  bool orderFinishedCook;
  bool inDelivery;
  bool completed;
  int id;
  UserOrders({
    required this.date,
    required this.item,
    required this.total,
    required this.adress,
    required this.isDelivey,
    required this.paymentMethod,
    required this.wantSachets,
    required this.molhoOrMaionese,
    required this.meatPoint,
    required this.name,
    required this.cooking,
    required this.orderFinishedCook,
    required this.inDelivery,
    required this.completed,
    required this.id,
  });
  final user = Auth().currentUser;
  Future addUserOrdersToDatabase() async {
    FirebaseFirestore.instance
        .collection('Users')
        .doc(user!.email)
        .collection('User_Orders')
        .doc(id.toString())
        .update({
      "order_date": date,
      "is_delivery": isDelivey,
      "meat_point": meatPoint,
      "sachets": wantSachets,
      "molho_ou_maionese": molhoOrMaionese,
      "item": item.toString(),
      "order_id": id,
      "client_name": name,
      "client_adress": adress,
      "payment_method": paymentMethod,
      "cooking": cooking,
      "order_finished_cook": orderFinishedCook,
      "order_in_delivery": inDelivery,
      "order_completed": completed,
      "order_total_price": total,
    }).catchError((err) {
      if (err.code == 'not-found') {
        FirebaseFirestore.instance
            .collection('Users')
            .doc(user!.email)
            .collection('User_Orders')
            .doc(id.toString())
            .set({
          "order_date": date,
          "is_delivery": isDelivey,
          "meat_point": meatPoint,
          "sachets": wantSachets,
          "molho_ou_maionese": molhoOrMaionese,
          "item": item.toString(),
          "order_id": id,
          "client_name": name,
          "client_adress": adress,
          "payment_method": paymentMethod,
          "cooking": cooking,
          "order_finished_cook": orderFinishedCook,
          "order_in_delivery": inDelivery,
          "order_completed": completed,
          "order_total_price": total,
        });
      }
    });
  }
}
