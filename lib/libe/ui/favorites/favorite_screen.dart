import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:shoestores/libe/common/utils.dart';
import 'package:shoestores/libe/data/favorite_manager.dart';
import 'package:shoestores/libe/data/product.dart';
import 'package:shoestores/libe/theme.dart';
import 'package:shoestores/libe/ui/product/details.dart';
import 'package:shoestores/libe/ui/widgets/image.dart';


class FavoriteListScreen extends StatelessWidget {
  const FavoriteListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('لیست علاقه مندی ها')),
      body: ValueListenableBuilder<Box<ProductEntity>>(
          valueListenable: favoriteManager.listenable,
          builder: (context, box, child) {
            final products = box.values.toList();
            if (products.isNotEmpty) {
              return ListView.builder(
                  itemCount: products.length,
                  padding: const EdgeInsets.only(top: 8, bottom: 100),
                  itemBuilder: (context, index) {
                    final product = products[index];
                    return InkWell(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) =>
                                ProductDetailScreen(product: product)));
                      },
                      onLongPress: () {
                        favoriteManager.delete(product);
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(
                            left: 16, right: 16, top: 8, bottom: 8),
                        child: Row(
                          children: [
                            SizedBox(
                              width: 110,
                              height: 110,
                              child: ImageLoadingService(
                                imageUrl: product.imageUrl,
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            Expanded(
                                child: Padding(
                              padding: const EdgeInsets.all(16),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    product.title,
                                    style: Theme.of(context)
                                        .textTheme
                                        .labelSmall!
                                        .apply(
                                          color:
                                              LightThemeColors.primaryTextColor,
                                        ),
                                  ),
                                  const SizedBox(
                                    height: 24,
                                  ),
                                  Text(
                                    product.previousPrice.withPriceLabel,
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyMedium!
                                        .apply(
                                            decoration:
                                                TextDecoration.lineThrough),
                                  ),
                                  Text(product.price.withPriceLabel)
                                ],
                              ),
                            ))
                          ],
                        ),
                      ),
                    );
                  });
            } else {
              return const Center(
                child: Text('اینجا خبری نیست!'),
              );
            }
          }),
    );
  }
}
