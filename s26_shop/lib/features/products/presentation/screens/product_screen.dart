import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:teslo_shop/features/products/presentation/providers/product_provider.dart';
import 'package:teslo_shop/features/shared/shared.dart';
import 'package:teslo_shop/features/shared/widgets/custom_product_field.dart';

import '../../../shared/widgets/full_screen_loader.dart';
import '../../domain/entities/product.dart';
import '../providers/product_form_provider.dart';

class ProductScreen extends ConsumerWidget {
  final String productId;

  const ProductScreen({super.key, required this.productId});

  void showSnack(BuildContext context) {
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Producto actualizado"))
    );
  }

  @override
  Widget build(BuildContext context, ref) {

    final productState = ref.watch( productProvider(productId) );

    return Scaffold(
      appBar: AppBar(
        title: const Text("Editar producto"),
        actions: [
          IconButton(onPressed: () async {
            final photo = await CameraGalleryServiceImpl().takePhoto();
            if (photo == null) return;
            ref.read( productFormProvider(productState.product!).notifier )
            .updateProductImage(photo);
          }, icon: const Icon(Icons.camera)),
          IconButton(onPressed: () async {
            final photo = await CameraGalleryServiceImpl().selectPhoto();
            if (photo == null) return;
            ref.read( productFormProvider(productState.product!).notifier )
            .updateProductImage(photo);
          }, icon: const Icon(Icons.browse_gallery))
        ],
      ),
      body: Center(
        child: productState.isLoading
         ? const FullLoader()
         : _ProductView(product: productState.product!,)
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if(productState.product == null) return;
          ref.read( productFormProvider(productState.product!).notifier )
          .onFormSubmited()
          .then((value) {
            if(!value) return;
            showSnack(context);
          });
        },
        child: const Icon(Icons.save),
      ),
    );
  }
}

class _ProductView extends ConsumerWidget {

  final Product product;

  const _ProductView({required this.product});

  @override
  Widget build(BuildContext context, ref) {

    final productForm = ref.watch(productFormProvider(product));

    final textStyles = Theme.of(context).textTheme;

    return ListView(
      children: [    
          SizedBox(
            height: 250,
            width: 600,
            child: _ImageGallery(images: productForm.images ),
          ),
    
          const SizedBox( height: 10 ),
          Center(child: Text( productForm.title.value, style: textStyles.titleSmall, textAlign: TextAlign.center, )),
          const SizedBox( height: 10 ),
          _ProductInformation( product: product ),
          
        ],
    );
  }
}


class _ProductInformation extends ConsumerWidget {
  final Product product;
  const _ProductInformation({required this.product});

  @override
  Widget build(BuildContext context, WidgetRef ref ) {

    final productForm = ref.watch(productFormProvider(product));    

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Generales'),
          const SizedBox(height: 15 ),
          CustomProductField( 
            isTopField: true,
            label: 'Nombre',
            initialValue: productForm.title.value,
            onChanged: ref.read( productFormProvider(product).notifier).onTitleChange,
            errorMessage: productForm.title.errorMessage,
          ),
          CustomProductField( 
            // isTopField: true,
            label: 'Slug',
            initialValue: productForm.slug.value,
            onChanged: ref.read( productFormProvider(product).notifier).onSlugChange,
            errorMessage: productForm.slug.errorMessage,
          ),
          CustomProductField( 
            isBottomField: true,
            label: 'Precio',
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
            initialValue: productForm.price.value.toString(),
            onChanged: (value) => ref.read( productFormProvider(product).notifier).onPriceChange(double.tryParse(value) ?? -1),
            errorMessage: productForm.price.errorMessage,
          ),

          const SizedBox(height: 15 ),
          const Text('Extras'),

          _SizeSelector(
            selectedSizes: productForm.size, 
            onSizeChanged: ref.read( productFormProvider(product).notifier).onSizeChaged,
          ),
          const SizedBox(height: 5 ),
          _GenderSelector( 
            selectedGender: productForm.gender,
            onGenderChanged: ref.read( productFormProvider(product).notifier).onGenderChange,
          ),
          
          const SizedBox(height: 15 ),
          CustomProductField( 
            isTopField: true,
            label: 'Existencias',
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
            initialValue: product.stock.toString(),
            onChanged: (value) => ref.read( productFormProvider(product).notifier).onStockChange( int.tryParse(value) ?? -1 ),
            errorMessage: productForm.inStock.errorMessage,
          ),

          CustomProductField( 
            maxLines: 6,
            label: 'Descripción',
            keyboardType: TextInputType.multiline,
            initialValue: productForm.description,
            onChanged: ref.read( productFormProvider(product).notifier).onDescChaged,
          ),

          CustomProductField( 
            isBottomField: true,
            maxLines: 2,
            label: 'Tags (Separados por coma)',
            keyboardType: TextInputType.multiline,
            initialValue: product.tags.join(', '),
            onChanged: ref.read( productFormProvider(product).notifier).onTagChange,
          ),

          const SizedBox(height: 100 ),
        ],
      ),
    );
  }
}

class _SizeSelector extends StatelessWidget {
  final List<String> selectedSizes;
  final List<String> sizes = const['XS','S','M','L','XL','XXL','XXXL'];

  final void Function(List<String> sizes) onSizeChanged;

  const _SizeSelector({
    required this.selectedSizes,
    required this.onSizeChanged
  });


  @override
  Widget build(BuildContext context) {
    return SegmentedButton(
      emptySelectionAllowed: true,
      showSelectedIcon: false,
      segments: sizes.map((size) {
        return ButtonSegment(
          value: size, 
          label: Text(size, style: const TextStyle(fontSize: 10))
        );
      }).toList(), 
      selected: Set.from( selectedSizes ),
      onSelectionChanged: (newSelection) {
        onSizeChanged(List.from(newSelection));
      },
      multiSelectionEnabled: true,
    );
  }
}

class _GenderSelector extends StatelessWidget {
  final String selectedGender;
  final List<String> genders = const['men','women','kid'];
  final List<IconData> genderIcons = const[
    Icons.man,
    Icons.woman,
    Icons.boy,
  ];

  final void Function(String gender) onGenderChanged;

  const _GenderSelector({
    required this.selectedGender, 
    required this.onGenderChanged
  });


  @override
  Widget build(BuildContext context) {
    return Center(
      child: SegmentedButton(
        emptySelectionAllowed: false,
        multiSelectionEnabled: false,
        showSelectedIcon: false,
        style: const ButtonStyle(visualDensity: VisualDensity.compact ),
        segments: genders.map((size) {
          return ButtonSegment(
            icon: Icon( genderIcons[ genders.indexOf(size) ] ),
            value: size, 
            label: Text(size, style: const TextStyle(fontSize: 12))
          );
        }).toList(), 
        selected: { selectedGender },
        onSelectionChanged: (newSelection) {
          onGenderChanged(newSelection.first);
        },
      ),
    );
  }
}

class _ImageGallery extends StatelessWidget {
  final List<String> images;
  const _ImageGallery({required this.images});

  @override
  Widget build(BuildContext context) {
 
    if(images.isEmpty) {
      return ClipRRect(
            borderRadius: const BorderRadius.all(Radius.circular(20)),
            child: Image.asset('assets/images/no-image.jpg', fit: BoxFit.cover ));
    }

    return PageView(
      scrollDirection: Axis.horizontal,
      controller: PageController(
        viewportFraction: 0.7
      ),
      children: images.map((e) {

        late ImageProvider imageProvider;
        if(e.startsWith("http")) {
          imageProvider = NetworkImage(e);
        } else {
          imageProvider = FileImage( File(e) );
        }

        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 9.0),
          child: ClipRRect(
            borderRadius: const BorderRadius.all(Radius.circular(20)),
            child: FadeInImage(
              fit: BoxFit.cover,
              image: imageProvider,
              placeholder: const AssetImage("assets/loaders/bottle-loader.gif"),
            )
          ),
        );
      },).toList()
    );
  }
}