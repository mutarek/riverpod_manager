import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:manager/core/constant/app_constant.dart';

final dioProvider = Provider<Dio>((ref){

  final dio = Dio(
    BaseOptions(
      baseUrl: AppConstants.baseUrl,
      connectTimeout: const Duration(seconds: 30),
      receiveTimeout: const Duration(seconds: 30),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
    )
  );

  // Add interceptors for logging and error handling
  dio.interceptors.add(
    LogInterceptor(
      request: true,
      requestHeader: true,
      requestBody: true,
      responseHeader: true,
      responseBody: true,
      error: true,
    ),
  );

  // Custom interceptor for authentication tokens
  dio.interceptors.add(
    InterceptorsWrapper(
      onRequest: (options, handler) async {
        // Add auth token here if needed
        // final token = await getAuthToken();
        // options.headers['Authorization'] = 'Bearer $token';
        return handler. next(options);
      },
      onError: (error, handler) async {
        // Handle token refresh logic here
        if (error.response?.statusCode == 401) {
          // Refresh token logic
        }
        return handler.next(error);
      },
    ),
  );

  return dio;

});