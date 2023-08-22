import 'package:dio/dio.dart';
import 'package:ecommerce/config/urls.dart';
import 'package:flutter/foundation.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

import '../../../presentation/resources/constants_manager.dart';

const String APPLICATION_JSON = "application/json";
const String CONTENT_TYPE = "content-type";
const String ACCEPT = "Accept";
const String AUTHORIZATION = "Authorization";
const String DEFAULT_LANGUAGE = "language";

class DioHelper {
  static late Dio dio;
  static DioHelper? _instance;

  DioHelper._(); // Private constructor

  static DioHelper get instance {
    _instance ??= DioHelper._(); // Create a new instance if not exists
    return _instance!;
  }

  static void init() {
    Map<String, String> headers = {
      CONTENT_TYPE: APPLICATION_JSON,
      // ACCEPT: APPLICATION_JSON,
      // AUTHORIZATION: Constants.token,
      // DEFAULT_LANGUAGE: language
    };

    dio = Dio(
      BaseOptions(
        baseUrl: Urls.baseUrl,
        receiveDataWhenStatusError: true,
        headers: headers,
        receiveTimeout: Constants.apiTimeOut,
        sendTimeout: Constants.apiTimeOut,
      ),
    );

    if (!kReleaseMode) {
      // It's debug mode so print app logs
      dio.interceptors.add(
        PrettyDioLogger(
          requestHeader: true,
          requestBody: true,
          responseHeader: true,
        ),
      );
    }
  }

  Future<Response> getData({
    required String url,
    Map<String, dynamic>? query,
    String? token,
  }) async {
    dio.options.headers = {
      AUTHORIZATION: token ?? '',
    };
    return await dio.get(
      url,
      queryParameters: query,
    );
  }

  Future<Response> postData({
    required String url,
    Map<String, dynamic>? query,
    required Map<String, dynamic> data,
    String? token,
  }) async {
    dio.options.headers = {
      AUTHORIZATION: token ?? '',
    };
    return dio.post(
      url,
      queryParameters: query,
      data: data,
    );
  }

  Future<Response> putData({
    required String url,
    Map<String, dynamic>? query,
    required Map<String, dynamic> data,
    String? token,
  }) async {
    dio.options.headers = {
      AUTHORIZATION: token ?? '',
    };
    return dio.put(
      url,
      queryParameters: query,
      data: data,
    );
  }

  Future<Response> deleteData({
    required String url,
    Map<String, dynamic>? query,
    Map<String, dynamic>? data,
    String? token,
  }) async {
    dio.options.headers = {
      AUTHORIZATION: token ?? '',
    };
    return dio.delete(
      url,
      queryParameters: query,
      data: data,
    );
  }
}
