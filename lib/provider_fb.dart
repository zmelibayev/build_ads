import 'package:build_ads/fb_service.dart';
import 'package:build_ads/model.dart';
import 'package:flutter/foundation.dart';

class AdsProvider with ChangeNotifier {
  final FirebaseService fbService = FirebaseService();

  List<AdsModel> _adsList = [];

  List<AdsModel> get adsList => _adsList;

  Future<void> getDataPrv() async {
    _adsList = await fbService.getData();
    notifyListeners();
  }

  Future<void> addAdsPrv(AdsModel newAdsItem) async {
    await fbService.addAds(newAdsItem);
    getDataPrv();
  }

  Future<void> updateAdsPrv(String idAdsItem, AdsModel updAdsItem) async {
    await fbService.updateAds(idAdsItem, updAdsItem);
    getDataPrv();
  }

  Future<void> deleteAdsPrv(String idAdsItem) async {
    await fbService.deleteAds(idAdsItem);
    getDataPrv();
  }
}
