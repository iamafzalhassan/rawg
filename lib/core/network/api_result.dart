import 'package:dio/dio.dart';

abstract class ApiResult<T> {
  const ApiResult();
}

class ApiFailure<T> extends ApiResult<T> {
  final int? statusCode;

  final String message;

  final DioException? dioException;

  const ApiFailure({this.statusCode, required this.message, this.dioException});
}

class ApiSuccess<T> extends ApiResult<T> {
  final T data;

  const ApiSuccess(this.data);
}
