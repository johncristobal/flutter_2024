import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:teslo_shop/features/products/domain/domain.dart';

import 'products_repo_provider.dart';


//Provider
final productsProvider = StateNotifierProvider<ProductsNotifier, ProductsState>((ref) {

  final productRepo = ref.watch( productsRepoProvider );
  return ProductsNotifier(productRepo: productRepo);
});

//  Notifier
class ProductsNotifier extends StateNotifier<ProductsState>{
  
  final ProductRepository productRepo;

  ProductsNotifier({
    required this.productRepo
  }) : super(ProductsState()) {
    loadNextPage();
  }

  Future<bool> createOrPost(Map<String, dynamic> productLike) async {
    try {
      final product = await productRepo.createUpdateProduct(productLike);
      final isInlist = state.products.any((element) => element.id == product.id);
      if(!isInlist) {
        state = state.copyWith(
          products: [...state.products, product]
        );
        return true;
      } 

      state = state.copyWith(
        products: state.products.map(
          (e) => (e.id == product.id) ? product : e
        ).toList()
      );
       return true;
    } catch(e){
      return false;
    }
  }

  Future loadNextPage() async {

    if(state.isloading || state.isLastPage) return;
    state = state.copyWith(
      isloading: true,
    );

    final products = await productRepo.getProductsByPage(
      limit: state.limit,
      offset: state.offset
    );
    
    if(products.isEmpty) {
      state = state.copyWith(
        isloading: false,
        isLastPage: true
      );
      return;
    }

    state = state.copyWith(
      isloading: false,
      isLastPage: false,
      offset: state.offset + 10,
      products: [...state.products, ...products]
    );
  }
}

// State
class ProductsState {

  final bool isLastPage;
  final int limit;
  final int offset;
  final bool isloading;
  final List<Product> products;

  ProductsState({
    this.isLastPage = false, 
    this.limit = 10, 
    this.offset = 0, 
    this.isloading = false,
    this.products = const []
  });

  ProductsState copyWith({
    bool? isLastPage,
    int? limit,
    int? offset,
    bool? isloading,
    List<Product>? products,
  }) => ProductsState(
    isLastPage: isLastPage ?? this.isLastPage,
    limit: limit ?? this.limit,
    offset: offset ?? this.offset,
    isloading: isloading ?? this.isloading,
    products: products ?? this.products,
  );
}