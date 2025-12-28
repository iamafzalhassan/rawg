import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:rawg/core/constants/api_constants.dart';
import 'package:rawg/core/secrets/app_secret.dart';

class ApiRequest {
  static final ApiRequest instance = ApiRequest._internal();

  factory ApiRequest() => instance;

  late final Dio dio;

  ApiRequest._internal() {
    dio = Dio(
      BaseOptions(
        baseUrl: ApiConstants.baseUrl,
        connectTimeout: const Duration(seconds: 30),
        receiveTimeout: const Duration(seconds: 30),
        sendTimeout: const Duration(seconds: 30),
        headers: const {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      ),
    );
    setupInterceptors();
  }

  void setupInterceptors() {
    dio.interceptors.add(
      PrettyDioLogger(
        compact: true,
        error: true,
        requestBody: true,
        requestHeader: true,
        responseBody: true,
        responseHeader: false,
      ),
    );

    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          options.queryParameters['key'] = AppSecret.rawgApiKey;
          final token = await getAuthToken();
          if (token != null) {
            options.headers['Authorization'] = 'Bearer $token';
          }
          handler.next(options);
        },
        onError: (error, handler) async {
          if (error.response?.statusCode == 401) {
            final newToken = await refreshToken();
            if (newToken != null) {
              error.requestOptions.headers['Authorization'] =
                  'Bearer $newToken';
              final response = await dio.fetch(error.requestOptions);
              return handler.resolve(response);
            }
          }
          handler.next(error);
        },
      ),
    );
  }

  Future<Response<T>> get<T>(
    String path, {
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) => dio.get<T>(path, queryParameters: queryParameters, options: options);

  Future<Response<T>> post<T>(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) => dio.post<T>(
    path,
    data: data,
    queryParameters: queryParameters,
    options: options,
  );

  Future<Response<T>> put<T>(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) => dio.put<T>(
    path,
    data: data,
    queryParameters: queryParameters,
    options: options,
  );

  Future<Response<T>> delete<T>(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) => dio.delete<T>(
    path,
    data: data,
    queryParameters: queryParameters,
    options: options,
  );

  Future<String?> getAuthToken() async => null;

  Future<String?> refreshToken() async => null;
}