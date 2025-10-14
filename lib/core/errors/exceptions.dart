import 'package:dio/dio.dart';

class Exceptions {
  static String handleError(DioException error) {
    switch (error.type) {
      case DioExceptionType.connectionTimeout:
        return "Connection timeout. Please check your internet connection.";
      case DioExceptionType.sendTimeout:
        return "Send timeout. Please try again.";
      case DioExceptionType.receiveTimeout:
        return "Receive timeout. Please try again.";
      case DioExceptionType.badResponse:
        return handleStatusCode(error.response?.statusCode);
      case DioExceptionType.cancel:
        return "Request was cancelled.";
      case DioExceptionType.connectionError:
        return "No internet connection. Please check your connectivity.";
      default:
        return "Something went wrong. Please try again.";
    }
  }

  static String handleStatusCode(int? statusCode) {
    switch (statusCode) {
      case 400:
        return "Bad request. Please check your input.";
      case 401:
        return "Unauthorized. Please login again.";
      case 403:
        return "Access denied.";
      case 404:
        return "Resource not found.";
      case 500:
        return "Internal server error. Please try again later.";
      default:
        return "Server error. Please try again.";
    }
  }
}