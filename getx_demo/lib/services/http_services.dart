import 'package:dio/dio.dart';
import 'package:getx_demo/const.dart';

class HttpServices {
  final Dio _dio = Dio();

  HttpServices() {
    _configureDio();
  }
  
  void _configureDio() {
    _dio.options = BaseOptions(
      baseUrl: "https://api.cryptorank.io/v1/",
      queryParameters: {
        "api_key" : CRYPTO_RANK_API_KEY,
      }
    );
  }

  Future<dynamic> get(String path) async {
    try {
      Response resp = await _dio.get(path);
      return resp.data;
    } catch(e) {
      print(e);
    }
  }
}