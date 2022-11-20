// ignore_for_file: public_member_api_docs, sort_constructors_first
class StoreStatusModel {
  final String storeStatus;
  StoreStatusModel({
    required this.storeStatus,
  });

  factory StoreStatusModel.fromJson(Map<String, dynamic> json) {
    return StoreStatusModel(storeStatus: json['storestatus']);
  }
}

List<StoreStatusModel> storeStatus = [];
