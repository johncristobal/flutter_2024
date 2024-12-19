import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_demo/controllers/assets_controller.dart';
import 'package:getx_demo/models/api_response.dart';
import 'package:getx_demo/services/http_services.dart';

  // GET_4 = manejar estado de la app
class AddAssetDialogController extends GetxController {
  RxBool loading = false.obs;  // GET_5 observable variable
  RxList<String> assets = <String>[].obs; // GET_8  // definismo variable tipo lista 

  RxString selectedAsset = "".obs;
  RxDouble assetValue = 0.0.obs;

  @override
  void onInit() {
    super.onInit();
    // Future.delayed(Durations.extralong4).then((value) {
    //   loading.value = false;
    // });
    _getAssets();
  }

  Future<void> _getAssets() async {
    loading.value = true;
    HttpServices serivces = Get.find(); // GET_7 // get instance de services (DI)
    var data = await serivces.get("currencies");
    CurrenciesListAPIResponse response = CurrenciesListAPIResponse.fromJson(data);
    response.data?.forEach((element) {
      assets.add(element.name!);
    },);

    selectedAsset.value = assets.first;

    loading.value = false;
  }

}

  // GET_6 en este widget conectaremos el controller
  // 1. cremos Get.put para crera controller 
  // 2. regresamos Obx widget conectar controller 
class AddAssetDialog extends StatelessWidget {

  final controller = Get.put(
    AddAssetDialogController(),
  );

  AddAssetDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Center(
        child: Material(
          child: Container(
            height: MediaQuery.sizeOf(context).height * 0.4,
            width: MediaQuery.sizeOf(context).width * 0.8,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              color: Colors.white
            ),
            child: _buildUI(context),
          ),
        ),
      ),
    );
  }
  
  Widget _buildUI(BuildContext context) {
    if(controller.loading.isTrue) {
      return const Center(
        child: SizedBox(
          height: 30,
          width: 30,
          child: CircularProgressIndicator(),
        ),
      );
    } else {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            DropdownButton(
              value: controller.selectedAsset.value,
              items: controller.assets.map((asset) {
                return DropdownMenuItem(
                  value: asset,
                  child: Text(asset),
                );
              }).toList(), 
              onChanged: (value) {
                if(value != null) {
                  controller.selectedAsset.value = value;
                }
              },
            ),

            TextField(
              onChanged: (value) {
                controller.assetValue.value = double.parse(value);
              },
              decoration: const InputDecoration(
                border: OutlineInputBorder()
              ),
              keyboardType: TextInputType.number,
            ),

            MaterialButton(
              onPressed: () {
                // GET_10 hacemos find de controller y llamamos metodo 
                AssetsController assetsController = Get.find();
                assetsController.addTracked(
                  controller.selectedAsset.value,
                  controller.assetValue.value
                );
                Get.back(
                  closeOverlays: true
                );
              },
              color: Theme.of(context).colorScheme.primary,
              child: const Text(
                "Add asset",
                style: TextStyle(
                  color: Colors.white
                ),
              ),
            )
          ],
        ),
      );
    }
  }
}