import 'package:get/get.dart';
import 'package:getx_demo/controllers/assets_controller.dart';
import 'package:getx_demo/services/http_services.dart';

Future<void> registerServices() async {
  Get.put(HttpServices());  // GET_3
}

Future<void> registerControllers() async {
  Get.put(AssetsController());  // GET_3
}

String getCryptoImageURL(String name) {
  return "https://raw.githubusercontent.com/ErikThiart/cryptocurrency-icons/master/128/${name.toLowerCase()}.png";
}
