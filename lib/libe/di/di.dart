import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:shoestores/libe/di/di.config.dart';

import '../common/http_client.dart';

final getIt = GetIt.instance;

@InjectableInit(
  initializerName: 'init', // default
  preferRelativeImports: true, // default
  asExtension: false, // default
)
void configureDependencies() {
  getIt.registerSingleton<Dio>(httpClient);
  init(getIt);
}
