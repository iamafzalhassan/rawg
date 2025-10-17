import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';

class Exceptions {
  static String handleError(DioException error) {
    switch (error.type) {
      case DioExceptionType.connectionTimeout:
        return "errors.connectionTimeout".tr();
      case DioExceptionType.sendTimeout:
        return "errors.sendTimeout".tr();
      case DioExceptionType.receiveTimeout:
        return "errors.receiveTimeout".tr();
      case DioExceptionType.badResponse:
        return handleStatusCode(error.response?.statusCode);
      case DioExceptionType.cancel:
        return "errors.cancelled".tr();
      case DioExceptionType.connectionError:
        return "errors.noInternet".tr();
      default:
        return "errors.default".tr();
    }
  }

  static String handleStatusCode(int? statusCode) {
    switch (statusCode) {
      case 400:
        return "errors.badRequest".tr();
      case 401:
        return "errors.unauthorized".tr();
      case 403:
        return "errors.accessDenied".tr();
      case 404:
        return "errors.notFound".tr();
      case 500:
        return "errors.serverError".tr();
      default:
        return "errors.default".tr();
    }
  }
}