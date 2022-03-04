class ApiResponse<T> {
  T? data;
  int? statusCode;
  String? statusMessage;

  ApiResponse({
    this.data,
    this.statusCode,
    this.statusMessage,
});
}