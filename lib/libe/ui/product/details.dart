import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoestores/libe/common/utils.dart';
import 'package:shoestores/libe/data/favorite_manager.dart';
import 'package:shoestores/libe/data/product.dart';
import 'package:shoestores/libe/data/repo/cart_repository.dart';
import 'package:shoestores/libe/theme.dart';
import 'package:shoestores/libe/ui/product/bloc/product_bloc.dart';
import 'package:shoestores/libe/ui/product/comment/comment_list.dart';
import 'package:shoestores/libe/ui/product/comment/insert/insert_comment_dialog.dart';
import 'package:shoestores/libe/ui/widgets/image.dart';


class ProductDetailScreen extends StatefulWidget {
  final ProductEntity product;

  const ProductDetailScreen({Key? key, required this.product})
      : super(key: key);

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  StreamSubscription<ProductState>? stateSubscription;

  final GlobalKey<ScaffoldMessengerState> _scaffoldKey = GlobalKey();

  @override
  void dispose() {
    stateSubscription?.cancel();
    _scaffoldKey.currentState?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: BlocProvider<ProductBloc>(
        create: (context) {
          final bloc = ProductBloc(cartRepository);
          stateSubscription = bloc.stream.listen((state) {
            if (state is ProductAddToCartSuccess) {
              _scaffoldKey.currentState?.showSnackBar(const SnackBar(
                  content: Text('با موفقیت به سبد خرید شما اضافه شد')));
            } else if (state is ProductAddToCartError) {
              _scaffoldKey.currentState?.showSnackBar(
                  SnackBar(content: Text(state.exception.message)));
            }
          });
          return bloc;
        },
        child: ScaffoldMessenger(
          key: _scaffoldKey,
          child: Scaffold(
            floatingActionButtonLocation:
            FloatingActionButtonLocation.centerFloat,
            floatingActionButton: SizedBox(
              width: MediaQuery
                  .of(context)
                  .size
                  .width - 48,
              child: BlocBuilder<ProductBloc, ProductState>(
                builder: (context, state) =>
                    FloatingActionButton.extended(
                      onPressed: () {
                        BlocProvider.of<ProductBloc>(context)
                            .add(CartAddButtonClick(widget.product.id));
                      },
                      label: state is ProductAddToCartButtonLoading
                          ? CupertinoActivityIndicator(
                        color: Theme
                            .of(context)
                            .colorScheme
                            .onSecondary,
                      )
                          : const Text('افزودن به سبد خرید'),
                    ),
              ),
            ),
            body: CustomScrollView(
              physics: defaultScrollPhysics,
              slivers: [
                SliverAppBar(
                  expandedHeight: MediaQuery
                      .of(context)
                      .size
                      .width * 0.8,
                  flexibleSpace:
                  ImageLoadingService(imageUrl: widget.product.imageUrl),
                  foregroundColor: LightThemeColors.primaryTextColor,
                  actions: [
                    IconButton(
                      onPressed: () {
                        favoriteManager.toggle(widget.product);
                      },
                      icon: ValueListenableBuilder(
                        valueListenable: favoriteManager.listenable,
                        builder: (context, box, child) {
                          return Icon(favoriteManager.isFavorite(widget.product)
                              ? CupertinoIcons.heart_fill
                              : CupertinoIcons.heart);
                        },
                      ),
                    ),
                  ],
                ),
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Expanded(
                                child: Text(
                                  widget.product.title,
                                  style: Theme
                                      .of(context)
                                      .textTheme
                                      .headlineMedium,
                                )),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text(
                                  widget.product.previousPrice.withPriceLabel,
                                  style: Theme
                                      .of(context)
                                      .textTheme
                                      .bodyMedium!
                                      .apply(
                                      decoration:
                                      TextDecoration.lineThrough),
                                ),
                                Text(widget.product.price.withPriceLabel),
                              ],
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 24,
                        ),
                        const Text(
                          'این کتونی شدیدا برای دویدن و راه رفتن مناسب هست و تقریبا. هیچ فشار مخربی رو نمیذارد به پا و زانوان شما انتقال داده شود',
                          style: TextStyle(height: 1.4),
                        ),
                        const SizedBox(
                          height: 24,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'نظرات کاربران',
                              style: Theme
                                  .of(context)
                                  .textTheme
                                  .titleMedium,
                            ),
                            TextButton(
                                onPressed: () {
                                  showModalBottomSheet(
                                      context: context,
                                      shape: const RoundedRectangleBorder(
                                          borderRadius: BorderRadius.vertical(
                                              top: Radius.circular(16))),
                                      useRootNavigator: true,
                                      builder: (context) {
                                        return InsertCommentDialog(
                                          productId: widget.product.id,
                                          scaffoldMessager:
                                          _scaffoldKey.currentState,
                                        );
                                      });
                                },
                                child: const Text('ثبت نظر'))
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                CommentList(productId: widget.product.id),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
