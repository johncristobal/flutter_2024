import 'dart:convert';

import 'package:get/get.dart';
import 'package:getx_demo/models/tracked_asset.dart';
import 'package:getx_demo/services/http_services.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/api_response.dart';
import '../models/coin_data.dart';

// GET_9 = nuevo controller para manejar lista de tracked
class AssetsController extends GetxController {

  RxList<TrackedAsset> trackedAssets = <TrackedAsset>[].obs;
  RxList<CoinData> coinData = <CoinData>[].obs;
  RxBool loading = false.obs;

  @override
  void onInit() {
    super.onInit();
    _getAssets();
    _loadTrackedAssetsFromStorage();
  }

  Future<void> _getAssets() async {
    loading.value = true;
    HttpServices http = Get.find();
    var response = await http.get("currencies");
    CurrenciesListAPIResponse currenciesListAPIResponse = CurrenciesListAPIResponse.fromJson( response );

    coinData.value = currenciesListAPIResponse.data ?? [];
    loading.value = false;
  }

  void addTracked(String name, double value) async {
    trackedAssets.add(
      TrackedAsset(name: name, amount: value)
    );

    // convert each asset into kjson and save list sring
    List<String> data = trackedAssets.map((asset) => jsonEncode(asset)).toList();
    // save list string into shared
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setStringList(
      "tracked_assets",
      data,
    );
  }

  void _loadTrackedAssetsFromStorage() async {
    // read preferences and map every json to TrackedAsset
    // assing list and controller do the next autom.
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? data = prefs.getStringList("tracked_assets");
    if (data != null) {
      trackedAssets.value = data
          .map(
            (e) => TrackedAsset.fromJson(
              jsonDecode(e),
            ),
          )
          .toList();
    }
  }

  double getPortfolioValue() {
    if (coinData.isEmpty) {
      return 0;
    }

    if (trackedAssets.isEmpty) {
      return 0;
    }
    
    double value = 0;
    for (TrackedAsset asset in trackedAssets) {
      value += getAssetPrice(asset.name!) * asset.amount!;
    }
    return value;
  }


  double getAssetPrice(String name) {
    CoinData? data = getCoinData(name);
    return data?.values?.uSD?.price?.toDouble() ?? 0;
  }

  CoinData? getCoinData(String name) {
    return coinData.firstWhereOrNull((e) => e.name == name);
  }

}
