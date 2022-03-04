import 'package:dio/dio.dart';
import 'package:music_player/core/network/api_service/response.dart';

extension ResponseExtension on Response {
  ApiResponse convert() {
    return ApiResponse(
      data: data,
      statusCode: statusCode,
      statusMessage: statusMessage,
    );
  }
}