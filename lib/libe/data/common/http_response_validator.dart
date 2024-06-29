import 'package:dio/dio.dart';
import 'package:shoestores/libe/common/exceptions.dart';


mixin HttpResponseValidator {
  validateResponse(Response response) {
    if (response.statusCode != 200) {
      throw AppException();
    }
  }
}
