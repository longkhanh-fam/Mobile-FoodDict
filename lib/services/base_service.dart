// ignore_for_file: unnecessary_question_mark

import 'package:dio/dio.dart';
import 'package:fooderapp/config/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:talker_dio_logger/talker_dio_logger.dart';

class BaseService {
  final Dio _dio = Dio();
  late SharedPreferences _prefs;

  // Private constructor
  BaseService._() {
    _setupDio();
    _init();
  }

  // Singleton instance
  static BaseService? _instance;

  // Factory method to get or create the instance
  factory BaseService() {
    _instance ??= BaseService._();
    return _instance!;
  }

  _init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  _setupDio() {
    _dio.options.baseUrl = baseUrl; // Replace with your API base URL
    _dio.options.connectTimeout = const Duration(seconds: 5); // 5 seconds
    _dio.options.receiveTimeout = const Duration(seconds: 5); // 5 seconds

    // Add interceptors for logging, headers, and error handling
    // _dio.interceptors.add(LogInterceptor(
    //   request: true,
    //   requestBody: true,
    //   responseHeader: true,
    //   responseBody: true,
    // ));
    _dio.interceptors.add(
      TalkerDioLogger(
        settings: const TalkerDioLoggerSettings(
          printRequestHeaders: true,
          printResponseHeaders: true,
          printResponseMessage: true,
        ),
      ),
    );
    _dio.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) {
        // Attach authentication header if token is available
        final String? authToken = _prefs.getString('jwt_token');
        if (authToken != null) {
          options.headers['Authorization'] = 'Bearer $authToken';
        }
        return handler.next(options);
      },
      onResponse: (response, handler) {
        // Handle response, if needed
        return handler.next(response);
      },
      onError: (DioException e, handler) {
        return handler.next(e);
      },
    ));
  }

  void setJwtToken(String accessToken) {
    _prefs.setString("jwt_token", accessToken);
  }

  void removeJwtToken(String accessToken) {
    _prefs.remove("jwt_token");
  }

  Future<Map<String, dynamic>> get(String endpoint) async {
    try {
      Response response = await _dio.get(endpoint);
      return response.data;
    } catch (e) {
      throw DioException(
        requestOptions: RequestOptions(path: endpoint),
        error: 'Error during GET request: $e',
      );
    }
  }

  Future<Map<String, dynamic>> post(String endpoint,
      [Map<String, dynamic>? data]) async {
    try {
      Response response = await _dio.post(endpoint, data: data);
      return response.data;
    } catch (e) {
      throw DioException(
        requestOptions: RequestOptions(path: endpoint),
        error: 'Error during POST request: $e',
      );
    }
  }

  Future<dynamic> patch(String endpoint, [Map<String, dynamic>? data]) async {
    try {
      Response response = await _dio.patch(endpoint, data: data);
      return response.data;
    } catch (e) {
      throw DioException(
        requestOptions: RequestOptions(path: endpoint),
        error: 'Error during PATCH request: $e',
      );
    }
  }

  Future<Response> delete(String endpoint) async {
    try {
      Response response = await _dio.delete(endpoint);
      return response;
    } catch (e) {
      throw DioException(
        requestOptions: RequestOptions(path: endpoint),
        error: 'Error during DELETE request: $e',
      );
    }
  }
}
