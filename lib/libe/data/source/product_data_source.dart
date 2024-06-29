import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:shoestores/libe/data/common/http_response_validator.dart';
import 'package:shoestores/libe/data/product.dart';


abstract class IProductDataSource {
  Future<List<ProductEntity>> getAll(int sort);

  Future<List<ProductEntity>> search(String searchTerm);
}

@Injectable(as: IProductDataSource)
class ProductRemoteDataSource
    with HttpResponseValidator
    implements IProductDataSource {
  final Dio httpClient;

  ProductRemoteDataSource(this.httpClient);

  @override
  Future<List<ProductEntity>> getAll(int sort) async {
    final response = await httpClient.get('product/list?sort=$sort');
    validateResponse(response);
    final products = <ProductEntity>[];
    (response.data as List).forEach((element) {
      products.add(ProductEntity.fromJson(element));
    });
    return products;
  }

  @override
  Future<List<ProductEntity>> search(String searchTerm) async {
    final response = await httpClient.get('product/search?q=$searchTerm');
    validateResponse(response);
    final products = <ProductEntity>[];
    (response.data as List).forEach((element) {
      products.add(ProductEntity.fromJson(element));
    });
    return products;
  }
}
