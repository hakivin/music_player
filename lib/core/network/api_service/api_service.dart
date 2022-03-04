import 'package:dio/dio.dart';
import 'package:music_player/core/error/exceptions.dart';
import 'package:music_player/core/util/network_util.dart';

import 'api_request_interface.dart';
import 'response.dart';

abstract class ApiServiceInterface {
  Future<ApiResponse> get(
    String url,
    ApiRequestInterface body, {
    Map<String, String>? headers,
  });

  Future<ApiResponse> post(
    String url,
    ApiRequestInterface body, {
    Map<String, String>? headers,
  });

  Future<ApiResponse> put(
    String url,
    ApiRequestInterface body, {
    Map<String, String>? headers,
  });

  Future<ApiResponse> delete(
    String url,
    ApiRequestInterface body, {
    Map<String, String>? headers,
  });

  Future<ApiResponse> patch(
    String url,
    ApiRequestInterface body, {
    Map<String, String>? headers,
  });
}

class ApiService extends ApiServiceInterface {
  Dio dio;

  ApiService(
    this.dio,
  );

  @override
  Future<ApiResponse> delete(String url, ApiRequestInterface body,
      {Map<String, String>? headers}) async {
    Response response;
    var data = body.encode();
    try {
      response = await dio.delete(
        url,
        data: data,
        options: Options(
          headers: headers,
          responseType: ResponseType.json,
        ),
      );
    } catch (error) {
      throw ServerException();
    }

    return response.convert();
  }

  @override
  Future<ApiResponse> get(String url, ApiRequestInterface body,
      {Map<String, String>? headers}) async {
    Response response;
    var data = body.encode();
    try {
      response = await dio.get(
        url,
        queryParameters: data,
        options: Options(
          headers: headers,
          responseType: ResponseType.json,
        ),
      );
    } catch (error) {
      throw ServerException();
    }

    return response.convert();
  }

  @override
  Future<ApiResponse> patch(String url, ApiRequestInterface body,
      {Map<String, String>? headers}) async {
    Response response;
    var data = body.encode();
    try {
      response = await dio.patch(
        url,
        data: data,
        options: Options(
          headers: headers,
          responseType: ResponseType.json,
        ),
      );
    } catch (error) {
      throw ServerException();
    }

    return response.convert();
  }

  @override
  Future<ApiResponse> post(String url, ApiRequestInterface body,
      {Map<String, String>? headers}) async {
    Response response;
    var data = body.encode();
    try {
      response = await dio.post(
        url,
        data: data,
        options: Options(
          headers: headers,
          responseType: ResponseType.json,
        ),
      );
    } catch (error) {
      throw ServerException();
    }

    return response.convert();
  }

  @override
  Future<ApiResponse> put(String url, ApiRequestInterface body,
      {Map<String, String>? headers}) async {
    Response response;
    var data = body.encode();
    try {
      response = await dio.put(
        url,
        data: data,
        options: Options(
          headers: headers,
          responseType: ResponseType.json,
        ),
      );
    } catch (error) {
      throw ServerException();
    }

    return response.convert();
  }
}
