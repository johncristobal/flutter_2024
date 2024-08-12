import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:formz/formz.dart';
import 'package:teslo_shop/config/constants/env.dart';
import 'package:teslo_shop/features/products/domain/domain.dart';
import 'package:teslo_shop/features/products/presentation/providers/products_provider.dart';
import '../../../shared/infrastructure/inputs/inputs.dart';

final productFormProvider = StateNotifierProvider.autoDispose.family<ProductFormNotifier, ProductFormState, Product>((ref, product) {

  // final createCallback = ref.watch( productsRepoProvider ).createUpdateProduct;
  final createCallback = ref.watch( productsProvider.notifier ).createOrPost;
  return ProductFormNotifier(
    product: product,
    onSubmitCallback: createCallback
  );
});

class ProductFormNotifier extends StateNotifier<ProductFormState> {

  final Future<bool> Function( Map<String, dynamic> productLike )? onSubmitCallback;
  
  ProductFormNotifier({
    this.onSubmitCallback,
    required Product product
  }) : super(ProductFormState(
    id: product.id,
    title: Title.dirty(product.title),
    slug: Slug.dirty(product.slug),
    price: Price.dirty( product.price),
    inStock: Stock.dirty( product.stock ),
    size: product.sizes,
    gender: product.gender,
    description: product.description,
    tags: product.tags,
    images: product.images
  ));

  void onTitleChange( String value ) {
    state = state.copyWith(
      title: Title.dirty(value),
      isFormValid: Formz.validate([
        Title.dirty(value),
        Slug.dirty(state.slug.value),
        Price.dirty(state.price.value),
        Stock.dirty(state.inStock.value),
      ])
    );
  }

  void onSlugChange( String value ) {
    state = state.copyWith(
      slug: Slug.dirty(value),
      isFormValid: Formz.validate([
        Title.dirty(state.title.value),
        Slug.dirty(value),
        Price.dirty(state.price.value),
        Stock.dirty(state.inStock.value),
      ])
    );
  }


  void onPriceChange( double value ) {
    state = state.copyWith(
      price: Price.dirty(value),
      isFormValid: Formz.validate([
        Title.dirty(state.title.value),
        Slug.dirty(state.slug.value),
        Price.dirty(value),
        Stock.dirty(state.inStock.value),
      ])
    );
  }

  void onStockChange( int value ) {
    state = state.copyWith(
      inStock: Stock.dirty(value),
      isFormValid: Formz.validate([
        Title.dirty(state.title.value),
        Slug.dirty(state.slug.value),
        Price.dirty(state.price.value),
        Stock.dirty(value),
      ])
    );
  }

  void onSizeChaged( List<String> sizes) {
    state = state.copyWith(
      size: sizes
    );
  }

  void onGenderChange( String gender) {
    state = state.copyWith(
      gender: gender
    );
  }

  void onDescChaged( String desc) {
    state = state.copyWith(
      description: desc
    );
  }

  void onTagChange( String tags) {
    state = state.copyWith(
      tags: tags.split(",")
    );
  }

  Future<bool> onFormSubmited() async {
    _touchAll();
    if (!state.isFormValid) return false;

    if( onSubmitCallback == null) return false;

    final productLike = {
      "id": (state.id == "new") ? null : state.id,
      "title": state.title.value,
      "price": state.price.value,
      "description": state.description,
      "slug": state.slug.value,
      "stock": state.inStock.value,
      "sizes": state.size,
      "gender": state.gender,
      "tags": state.tags,
      "images": state.images.map((e) => e.replaceAll("${Environment.apiUrl}/files/product/", "")).toList()
    };

    try {
      return await onSubmitCallback!(productLike);
    } catch(e) {
      return false;
    }
  }

  void updateProductImage(String path) {
    state = state.copyWith(
      images: [...state.images, path]
    );
  }

  void _touchAll() {
    state = state.copyWith(
      isFormValid: Formz.validate([
        Title.dirty(state.title.value),
        Slug.dirty(state.slug.value),
        Price.dirty(state.price.value),
        Stock.dirty(state.inStock.value),
      ])
    );
  }

  Future<void> saveProdcut() async {
    try {
      
    } catch(e) {
      // 404 not found
     
    }
  }
}

class ProductFormState {
  final bool isFormValid;
  final String? id;
  final Title title;
  final Slug slug;
  final Price price;
  final List<String> size;
  final String gender;
  final Stock inStock;
  final String description;
  final List<String> tags;
  final List<String> images;

  ProductFormState({
    this.isFormValid = false, 
    this.id, 
    this.title = const Title.dirty(""), 
    this.slug = const Slug.dirty(""), 
    this.price = const Price.dirty(0), 
    this.size = const [],
    this.gender = "men", 
    this.inStock = const Stock.dirty(0), 
    this.description = "", 
    this.tags = const [], 
    this.images = const []
  });

  ProductFormState copyWith({
    bool? isFormValid,
    String? id,
    Title? title,
    Slug? slug,
    Price? price,
    List<String>? size,
    String? gender,
    Stock? inStock,
    String? description,
    List<String>? tags,
    List<String>? images,
  }) => ProductFormState(
    isFormValid: isFormValid ?? this.isFormValid,
    id: id ?? this.id,
    title: title ?? this.title,
    slug: slug ?? this.slug,
    price: price ?? this.price,
    size: size ?? this.size,
    gender: gender ?? this.gender,
    inStock: inStock ?? this.inStock,
    description: description ?? this.description,
    tags: tags ?? this.tags,
    images: images ?? this.images,
  );

}