import 'package:flutter/material.dart';
import 'package:shoestores/libe/common/http_client.dart';
import 'package:shoestores/libe/data/add_to_cart_response.dart';
import 'package:shoestores/libe/data/cart_response.dart';
import 'package:shoestores/libe/data/source/cart_data_source.dart';

final cartRepository = CartRepository(CartRemoteDataSource(httpClient));

abstract class ICartRepository extends ICartDataSource {}

class CartRepository extends ChangeNotifier implements ICartRepository {
  final ICartDataSource dataSource;
  static final ValueNotifier<int> cartItemCountNotifier = ValueNotifier(0);

  CartRepository(this.dataSource);

  // @override
//   Future<AddToCartResponse> add(int productId){
// //      Object? values;
// // dataSource.add(productId).then((value) {
// //         notifyListeners();
// //         values=value;
// //       });
// //       return values;
// //   }
// return Exception();
//   }

  @override
  Future<AddToCartResponse> changeCount(int cartItemId, int count) {
    return dataSource.changeCount(cartItemId, count);
  }

  @override
  Future<int> count() async {
    final count = await dataSource.count();
    cartItemCountNotifier.value = count;
    return count;
  }

  @override
  Future<void> delete(int cartItemId) {
    return dataSource.delete(cartItemId);
  }

  @override
  Future<CartResponse> getAll() => dataSource.getAll();
  
  @override
  Future<AddToCartResponse> add(int productId) {
    // TODO: implement add
    throw UnimplementedError();
  }
}
