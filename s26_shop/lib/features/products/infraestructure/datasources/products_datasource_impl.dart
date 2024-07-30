import 'package:dio/dio.dart';
import 'package:teslo_shop/config/constants/env.dart';
import 'package:teslo_shop/features/products/domain/domain.dart';

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
  Future<Product> createUpdateProduct(Map<String, dynamic> productLike) {
    // TODO: implement createUpdateProduct
    throw UnimplementedError();
  }

  @override
  Future<Product> getProductsById(String id) {
    // TODO: implement getProductsById
    throw UnimplementedError();
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