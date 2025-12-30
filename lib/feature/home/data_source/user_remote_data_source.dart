import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:manager/core/constant/app_constant.dart';
import 'package:manager/core/network/dio_client.dart';
import 'package:manager/feature/home/data/user_model.dart';

final userRemoteDataSourceProvider = Provider<UserRemoteDataSource>((ref){
  final dio = ref.watch(dioProvider);
  return UserRemoteDataSource(dio);
});



class UserRemoteDataSource {
  final Dio _dio;

  UserRemoteDataSource(this._dio);

  /// Get all users
  Future<List<UserModelResponse>> getUsers() async {
    try {
      final response = await _dio.get(AppConstants.users);
      if (response.statusCode == 200) {
        final List<dynamic> data = response.data;
        return data.map((json) => UserModelResponse.fromJson(json)).toList();
      } else {
        throw DioException(
          requestOptions: response.requestOptions,
          response: response,
          type: DioExceptionType.badResponse,
          error: 'Failed to load users',
        );
      }
    } on DioException catch (e) {
      throw _handleDioError(e);
    }
  }

  /// Centralized error handling
  Exception _handleDioError(DioException error) {
    switch (error.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        return Exception('Connection timeout.  Please try again.');

      case DioExceptionType. badResponse:
        final statusCode = error.response?.statusCode;
        switch (statusCode) {
          case 400:
            return Exception('Bad request');
          case 401:
            return Exception('Unauthorized.  Please login again.');
          case 403:
            return Exception('Forbidden');
          case 404:
            return Exception('Resource not found');
          case 500:
            return Exception('Internal server error');
          default:
            return Exception('Received invalid status code: $statusCode');
        }

      case DioExceptionType.cancel:
        return Exception('Request cancelled');

      case DioExceptionType.connectionError:
        return Exception('No internet connection');

      default:
        return Exception('Something went wrong:  ${error.message}');
    }
  }
}