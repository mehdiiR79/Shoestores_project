import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shoestores/libe/common/utils.dart';
import 'package:shoestores/libe/data/favorite_manager.dart';
import 'package:shoestores/libe/data/product.dart';
import 'package:shoestores/libe/ui/product/details.dart';
import 'package:shoestores/libe/ui/widgets/image.dart';


class ProductItem extends StatelessWidget {
  const ProductItem({
    Key? key,
    required this.product,
    required this.borderRadius,
    this.itemWidth = 176,
    this.itemHeight = 189,
    this.imageSquare = false,
  }) : super(key: key);

  final ProductEntity product;
  final BorderRadius borderRadius;
  final bool imageSquare;

  final double itemWidth;
  final double itemHeight;

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(4.0),
        child: InkWell(
          borderRadius: borderRadius,
          onTap: () => Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => ProductDetailScreen(
                    product: product,
                  ))),
          child: SizedBox(
            width: itemWidth,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(
                  children: [
                    AspectRatio(
                      aspectRatio: imageSquare ? 1.5 : 0.93,
                      child: ImageLoadingService(
                        imageUrl: product.imageUrl,
                        borderRadius: borderRadius,
                      ),
                    ),
                    Positioned(
                      right: 8,
                      top: 8,
                      child: InkWell(
                        onTap: () {
                          favoriteManager.toggle(product);
                        },
                        child: Container(
                          width: 32,
                          height: 32,
                          alignment: Alignment.center,
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.white,
                          ),
                          child: ValueListenableBuilder(
                            valueListenable: favoriteManager.listenable,
                            builder: (context, box, child) {
                              return Icon(
                                  favoriteManager.isFavorite(product)
                                      ? CupertinoIcons.heart_fill
                                      : CupertinoIcons.heart,
                                  size: 20);
                            },
                          ),
                        ),
                      ),
                    )
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    product.title,
                    maxLines: 1,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 8, left: 8),
                  child: Text(
                    product.previousPrice.withPriceLabel,
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium!
                        .copyWith(decoration: TextDecoration.lineThrough),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 8, right: 8, top: 4),
                  child: Text(product.price.withPriceLabel),
                ),
              ],
            ),
          ),
        ));
  }
}
