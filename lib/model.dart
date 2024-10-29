import 'package:cloud_firestore/cloud_firestore.dart';

class AdsModel {
  String id;
  String adsName;
  String adsDescription;
  String housePlace;
  String homeScale;
  String adsPrice;
  String adsImgUrl;

  AdsModel({
    this.id = '',
    this.adsName = '',
    this.adsDescription = '',
    this.housePlace = '',
    this.homeScale = '',
    this.adsPrice = '',
    this.adsImgUrl = '',
  });

  factory AdsModel.fromMapFb(Map<String, dynamic> data, String documentId) {
    return AdsModel(
      id: documentId,
      adsName: data['adsName'].toString(),
      adsDescription: data['adsDescription'].toString(),
      housePlace: data['housePlace'].toString(),
      homeScale: data['homeScale'].toString(),
      adsPrice: data['adsPrice'].toString(),
      adsImgUrl: data['adsImgUrl'].toString(),
    );
  }

  Map<String, dynamic> toMapFb() {
    return {
      'id': id,
      'adsName': adsName,
      'adsDescription': adsDescription,
      'housePlace': housePlace,
      'homeScale': homeScale,
      'adsPrice': adsPrice,
      'adsImgUrl': adsImgUrl,
      'timestamp': Timestamp.now(),
    };
  }
}
