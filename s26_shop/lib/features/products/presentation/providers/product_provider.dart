import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:teslo_shop/features/products/domain/domain.dart';
import 'package:teslo_shop/features/products/presentation/providers/products_repo_provider.dart';

final productProvider = StateNotifierProvider.autoDispose.family<ProductNotifier, ProductState, String>((ref, productId) {
  final productRepo = ref.watch( productsRepoProvider);
  return ProductNotifier(
    productRepository: productRepo,
    productId: productId
  );
});

class ProductNotifier extends StateNotifier<ProductState> {

  final ProductRepository productRepository;

  ProductNotifier({
    required this.productRepository,
    required String productId,
  }) : super(ProductState(id: productId)) {
    loadProdcut();
  }

  Product newEmptyProduct() {
    return Product(
      id: "new", 
      title: "",
      price: 0,
      description: "", 
      slug: "", 
      stock: 0,
      sizes: [],
      gender: "men", 
      tags: [], 
      images: []
    );
  }
  Future<void> loadProdcut() async {
    try {
      if(state.id == "new") {
        state = state.copyWith(
          isLoading: false,
          product: newEmptyProduct()
        );
      } else {
        final product = await productRepository.getProductsById(state.id);
        state = state.copyWith(
          isLoading: false,
          product: product
        );
      }
    } catch(e) {
      // 404 not found
      print(e);
    }
  }
}

class ProductState {
  final String id;
  final Product? product;
  final bool isLoading;
  final bool isSaving;

  ProductState({
    required this.id, 
    this.product,
    this.isLoading = true, 
    this.isSaving = false
  });

  ProductState copyWith({
    String? id,
    Product? product,
    bool? isLoading,
    bool? isSaving,
  }) => ProductState(
    id : id ?? this.id, 
    product : product ?? this.product, 
    isLoading : isLoading ?? this.isLoading, 
    isSaving : isSaving ?? this.isSaving, 
  );

}