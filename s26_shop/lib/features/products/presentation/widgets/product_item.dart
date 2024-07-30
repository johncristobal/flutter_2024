import 'package:flutter/material.dart';
import 'package:teslo_shop/features/products/domain/entities/product.dart';

class ProductCard extends StatelessWidget {

  final Product product;

  const ProductCard({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ImageViewer(images: product.images),
        Text(product.title),
        const SizedBox(height: 20,),
      ],
    );
  }
}

class ImageViewer extends StatelessWidget {
  final List<String> images;
  const ImageViewer({super.key, required this.images});

  @override
  Widget build(BuildContext context) {
    if(images.isEmpty) {
      return ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Image.asset(
          "assets/images/no-image.jpg",
          fit: BoxFit.cover, 
          height: 250,
        ),
      );
    }

    return ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: FadeInImage(
          image: NetworkImage(images.first),
          fit: BoxFit.cover, 
          placeholder: const AssetImage("assets/loaders/bottle-loader.gif"),
          fadeOutDuration: const Duration(milliseconds: 100),
          height: 250,
        ),
      );
  }
}