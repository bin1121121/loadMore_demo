import 'dart:async';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:loadmore_demo/core/resource.dart';
import 'package:loadmore_demo/core/resource_type.dart';

class NetworkBoundResource<RequestType, ResultType> {
  final Completer<Resource<ResultType>> _result =
      Completer<Resource<ResultType>>();
  Future<Resource<ResultType>> getAsFuture() => _result.future;

  Stream<Resource<ResultType>> getAsStream() =>
      Stream.fromFuture(_result.future);

  final Future<RequestType> Function() createSerializedCall;
  final bool shouldFetch;
  final Future<ResultType> Function()? loadFromDb;
  final Future<void> Function(ResultType data)? saveCallResult;
  final ResultType Function(RequestType json)? parsedData;
  NetworkBoundResource({
    required this.createSerializedCall,
    this.shouldFetch = true,
    this.loadFromDb,
    this.saveCallResult,
    this.parsedData,
  }) {
    shouldFetch ? _fetchFromServerWithSerialization() : _fetchFromDB();
  }

  Future<void> _fetchFromServerWithSerialization() async {
    createSerializedCall.call().then((RequestType resource) async {
      ResultType? result;
      if (resource is ResultType) {
        result = resource;
      } else {
        result = parsedData?.call(resource);
      }
      if (result != null) {
        await saveCallResult?.call(result); // cache database
      }

      if (loadFromDb != null) {
        result = await loadFromDb!(); // call request from database
      }

      if (result != null) {
        _result.complete(Resource.withHasData(result));
      } else {
        _result.complete(Resource.withNoData());
      }
    }).catchError((error) async {
      ResultType? data = await loadFromDb?.call(); // call request from database
      if (error is DioException) {
        _result.complete(Resource.withError(error, data: data));
      } else if (error is SocketException) {
        _result.complete(Resource(
          message: error.osError?.message ?? error.message,
          code: error.osError?.errorCode ?? ResourceType.requestDisconnect,
          data: data,
        ));
      } else {
        _result.complete(Resource(
          message: error.toString(),
          code: ResourceType.requestResponse,
          data: data,
        ));
      }
    });
  }

  _fetchFromDB() async {
    ResultType? result = await loadFromDb?.call(); // call request from database
    if (result == null) {
      _result.complete(Resource.withNoData());
    } else {
      _result.complete(Resource.withHasData(result));
    }
  }
}
