import 'package:hamzahllc/core/helper/network/network_exception.dart';
import 'package:hamzahllc/core/helper/network/network_layer.dart';
import 'package:dio_cache_interceptor/dio_cache_interceptor.dart';
import 'package:hamzahllc/core/util/constants/app_data.dart';

class NewsRepository{

  getNews({required String apiCode,Map<String,String> queryParameters=const {}}) async {
    try{
      queryParameters.addAll({
        "apiKey":AppData.API_KEY
      });
      final response = await NetworkLayer().get(
          path: apiCode,
          queryParameters: queryParameters,
          cachePolicy: CachePolicy.refreshForceCache,
          days: 1
      );
      return response.data;
    } on DioExceptionHandler catch(error){
      rethrow;
    }
  }


}