import 'package:dio/dio.dart';
import 'package:loadmore_demo/core/resource_type.dart';
import 'package:loadmore_demo/utils/app_languages.dart';

class Resource<DataType> {
  int code;
  String message;
  DataType? data;
  Resource({this.code = 0, this.message = "", this.data});

  Map<String, dynamic> toJson() {
    return {
      'code': code,
      'message': message,
      'data': data,
    };
  }

  factory Resource.withError(DioException error, {DataType? data}) {
    String message = '';
    final int code;
    switch (error.type) {
      case DioExceptionType.connectionError:
      case DioExceptionType.connectionTimeout:
        code = ResourceType.requestConnectTimeout;
        message = AppLanguages.connectTimeout;
        break;
      case DioExceptionType.sendTimeout:
        code = ResourceType.requestSendTimeout;
        message = AppLanguages.sendTimeout;
        break;
      case DioExceptionType.receiveTimeout:
        code = ResourceType.requestReceiveTimeout;
        message = AppLanguages.receiveTimeout;
        break;
      case DioExceptionType.badResponse:
        Response? response = error.response;
        code = response?.statusCode ?? ResourceType.requestResponse;
        if (response != null && code != ResourceType.requestErrorToken) {
          message = response.data is String
              ? response.data
              : response.data is Map<String, dynamic>
                  ? response.data["message"] ?? ''
                  : '';
        }
        break;
      case DioExceptionType.cancel:
        code = ResourceType.requestCancel;
        break;
      case DioExceptionType.badCertificate:
      case DioExceptionType.unknown:
        code = ResourceType.requestErrorServer;
        message = error.message ?? "";
        break;
    }

    return Resource(message: message, code: code);
  }

  factory Resource.withDisconnect() => Resource(
        code: ResourceType.requestDisconnect,
        message: AppLanguages.disconnect,
      );
  factory Resource.withNoData() => Resource(
        code: ResourceType.requestNullData,
        message: AppLanguages.nullData,
      );
  factory Resource.withHasData(DataType data) => Resource(
        code: ResourceType.requestSuccess,
        message: AppLanguages.success,
        data: data,
      );
}
