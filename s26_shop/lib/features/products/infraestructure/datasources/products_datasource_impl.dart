import 'package:dio/dio.dart';
import 'package:teslo_shop/config/constants/env.dart';
import 'package:teslo_shop/features/products/domain/domain.dart';
import 'package:teslo_shop/features/products/infraestructure/errors/product_errors.dart';

import '../mappers/product_mapper.dart';

class ProductDatasourceImpl extends ProductDatasource {

  late final Dio dio;
  final String accessToken;

  ProductDatasourceImpl({
    required this.accessToken
  }) : dio = Dio(BaseOptions(
    baseUrl: Environment.apiUrl,
    headers: {
      "Authorization" : "bearer $accessToken"
    }
  ));

  @override
  Future<Product> createUpdateProduct(Map<String, dynamic> productLike) async {
    try {
      final String? id = productLike["id"];
      final String method = (id == null) ? "POST" : "PATCH";
      final String url = (id == null) ? "/products" : "/products/$id";
      productLike.remove("id");

      final response = await dio.request(
        url,
        data: productLike,
        options: Options(
          method: method
        )
      );

      final product = ProductMapper.jsonToEntity(response.data);
      return product;
    } catch(e) {
      throw Exception();
    }
  }

  @override
  Future<Product> getProductsById(String id) async {
    try {
      final resp = await dio.get("/products/$id");
      final product = ProductMapper.jsonToEntity(resp.data);
      return product;
    } on DioException catch(e){
      if(e.response!.statusCode == 404) {
        throw ProductNotFound();
      }
      throw Exception();
    } catch(e) {
      print(e);
      throw Exception();
    }
  }

  @override
  Future<List<Product>> getProductsByPage({int limit = 10, int offset = 0}) async {
    final resp = await dio.get<List>("/products?limit=$limit&offset=$offset");
    final List<Product> products = [];
    for (final product in resp.data ?? []) {
      products.add( ProductMapper.jsonToEntity(product));
    }

    return products;
  }

  @override
  Future<List<Product>> getProductsByTerm(String term) {
    // TODO: implement getProductsByTerm
    throw UnimplementedError();
  }

}