import 'package:dio/dio.dart';

abstract class ApiResult<T> {
  const ApiResult();
}

class ApiSuccess<T> extends ApiResult<T> {
  final T data;

  const ApiSuccess(this.data);
}

class ApiFailure<T> extends ApiResult<T> {
  final String message;
  final int? statusCode;
  final DioException? dioException;

  const ApiFailure({required this.message, this.statusCode, this.dioException});
}