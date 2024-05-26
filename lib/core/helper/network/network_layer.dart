import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:hamzahllc/core/helper/local_storage.dart';
import 'package:hamzahllc/core/util/constants/app_data.dart';
import 'network_exception.dart';
import 'network_logging.dart';
import 'package:dio_cache_interceptor/dio_cache_interceptor.dart';
import 'package:dio_cache_interceptor_hive_store/dio_cache_interceptor_hive_store.dart';

class NetworkLayer{
  static NetworkLayer? _instance;

  NetworkLayer._internal();

  Dio _dio = Dio(
      BaseOptions(
        baseUrl: AppData.BASE_URL,
        sendTimeout: Duration(seconds: 60),
        receiveTimeout: Duration(seconds: 60),
        connectTimeout: Duration(seconds: 60),
      )
  )..interceptors.add(NetworkLogging());

  factory NetworkLayer() {
    _instance = _instance ?? NetworkLayer._internal();
    return _instance!;
  }

  cacheNetwork({
    required CachePolicy cachePolicy,
    required int days
  }){
    _dio.interceptors.add(DioCacheInterceptor(
      options: CacheOptions(
        store: HiveCacheStore(LocalStorage().storagePath.path),
        policy: cachePolicy,
        hitCacheOnErrorExcept: [401, 403],
        maxStale: Duration(days: days),
        priority: CachePriority.high,
        cipher: null,
        keyBuilder: CacheOptions.defaultCacheKeyBuilder,
        allowPostMethod: false,
      ),
    ));
  }

  Future<dynamic> get({required String path,
    Map<String,String>? queryParameters,
    Options? options,
    CachePolicy cachePolicy=CachePolicy.noCache,
    int days=0
  }) async {
    try{
      cacheNetwork(
        days: days,
        cachePolicy: cachePolicy
      );

      Response response = await _dio.get(path,
          queryParameters: queryParameters,
          options: options,
      );
      return response;
    }on DioException catch (dioError) {
      DioExceptionHandler error = DioExceptionHandler.fromDioError(dioError);
      throw error;
    }
  }

}