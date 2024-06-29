// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:dio/dio.dart' as _i4;
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;
import 'package:shoestores/libe/data/repo/auth_repository.dart';
import 'package:shoestores/libe/data/repo/product_repository.dart';
import 'package:shoestores/libe/data/source/auth_data_source.dart';
import 'package:shoestores/libe/data/source/product_data_source.dart';



/// ignore_for_file: unnecessary_lambdas
/// ignore_for_file: lines_longer_than_80_chars
/// initializes the registration of main-scope dependencies inside of [GetIt]
_i1.GetIt init(
  _i1.GetIt getIt, {
  String? environment,
  _i2.EnvironmentFilter? environmentFilter,
}) {
  final gh = _i2.GetItHelper(
    getIt,
    environment,
    environmentFilter,
  );
  gh.factory<IAuthDataSource>(
      () => AuthRemoteDataSource(gh<_i4.Dio>()));
  gh.lazySingleton<IAuthRepository>(
      () => AuthRepository(gh<IAuthDataSource>()));
  gh.factory<IProductDataSource>(
      () => ProductRemoteDataSource(gh<_i4.Dio>()));
  gh.factory<IProductRepository>(
      () => ProductRepository(gh<IProductDataSource>()));
  return getIt;
}
