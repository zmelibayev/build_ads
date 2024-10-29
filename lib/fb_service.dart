import 'package:build_ads/model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseService {
  final CollectionReference adsCollection =
      FirebaseFirestore.instance.collection('buildads');

//----------------Get Data Fb----------------------------------

  Future<List<AdsModel>> getData() async {
    QuerySnapshot snapshotData =
        await adsCollection.orderBy('timestamp', descending: true).get();
    return snapshotData.docs
        .map((elem) =>
            AdsModel.fromMapFb(elem.data() as Map<String, dynamic>, elem.id))
        .toList();
  }

//---------------------Add Ads---------------------

  Future<void> addAds(AdsModel newAds) async {
    await adsCollection.add(newAds.toMapFb());
  }

//---------------------Update Ads-------------------------
  Future<void> updateAds(String idAds, AdsModel updAds) async {
    await adsCollection.doc(idAds).update(updAds.toMapFb());
  }

//--------------------Delete Ads ----------------

  Future<void> deleteAds(String idAds) async {
    await adsCollection.doc(idAds).delete();
  }
}
