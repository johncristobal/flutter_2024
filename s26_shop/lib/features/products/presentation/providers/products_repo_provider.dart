

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:teslo_shop/features/auth/presentation/providers/auth_provider.dart';
import 'package:teslo_shop/features/products/domain/repositories/producto_repo.dart';
import 'package:teslo_shop/features/products/infraestructure/datasources/products_datasource_impl.dart';
import 'package:teslo_shop/features/products/infraestructure/repositories/product_repo_impl.dart';

final productsRepoProvider = Provider<ProductRepository>((ref) {

  final token = ref.watch( authProvider ).user?.token ?? "";
  final productsRepo = ProductRepositoryImpl(
    ProductDatasourceImpl(accessToken: token)
  );
  return productsRepo;
});
