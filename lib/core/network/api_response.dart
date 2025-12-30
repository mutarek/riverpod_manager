class ApiResult<T> {
  final T? data;
  final String? error;
  final bool isLoading;
  final int? statusCode;

  const ApiResult(
      {this.data, this.error, required this.isLoading, this.statusCode});


  factory ApiResult.loading() => ApiResult(isLoading: true);

  factory ApiResult.success(T data) => ApiResult(data: data, isLoading: false);

  factory ApiResult.failure(String error, [int? statusCode]){
    return ApiResult(statusCode: statusCode, error: error, isLoading: false);
  }

  bool get isSuccess => data != null && error == null;
  bool get isError => error != null;



}