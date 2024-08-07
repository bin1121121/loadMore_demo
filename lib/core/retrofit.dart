import 'package:dio/dio.dart';
import 'package:dio/io.dart';

class Retrofit extends DioForNative {
  Retrofit({
    String? baseUrl,
    BaseOptions? options,
  }) : super(options) {
    interceptors.add(
      InterceptorsWrapper(
        onRequest: _requestInterceptor,
        onError: _errorInterceptor,
      ),
    );
  }

  void _requestInterceptor(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) {
    handler.next(options);
  }

  void _errorInterceptor(
    DioException error,
    ErrorInterceptorHandler handler,
  ) {
    handler.next(error);
  }
}
