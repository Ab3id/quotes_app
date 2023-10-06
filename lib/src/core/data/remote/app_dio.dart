import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AppDio with DioMixin implements Dio {
  AppDio._() {
    const String baseURL = 'https://type.fit/api';
    options = BaseOptions(
      baseUrl: baseURL,
      contentType: 'application/json',
      connectTimeout: const Duration(milliseconds: 30000),
      sendTimeout: const Duration(milliseconds: 30000),
      receiveTimeout: const Duration(milliseconds: 30000),
    );
    httpClientAdapter = IOHttpClientAdapter();
  }

  static Dio dioInstance() => AppDio._();
}

final dioProvider = Provider<Dio>((ref) => AppDio.dioInstance());
