// ignore_for_file: public_member_api_docs, sort_constructors_first
class GetPixInfoModel {
  int id;
  double transactionAmount;
  String status;
  String paymentKey;
  String qrCodeImage;
  GetPixInfoModel({
    required this.id,
    required this.transactionAmount,
    required this.status,
    required this.paymentKey,
    required this.qrCodeImage,
  });
}

class GetPixPaymentId {
  int id;
  GetPixPaymentId({
    required this.id,
  });
}

GetPixInfoModel? pixInfo;
