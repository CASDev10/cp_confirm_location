import 'package:dio/browser.dart';
import 'package:dio/dio.dart';

import '../../config/environment.dart';

class DioClient extends DioForBrowser {
  final Environment _environment;

  DioClient({required Environment environment}) : _environment = environment {
    options = BaseOptions(
      baseUrl: _environment.baseUrl,
      responseType: ResponseType.json,
    );

    // Add interceptors
    interceptors.addAll([
      LogInterceptor(
        request: true,
        requestHeader: true,
        requestBody: true,
        responseHeader: true,
        responseBody: true,
      ),
    ]);
  }
}
