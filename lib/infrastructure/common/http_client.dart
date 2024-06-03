import 'package:dio/dio.dart';
import 'package:time_planner_mobile/app_consts.dart';
import 'package:time_planner_mobile/infrastructure/common/token_interceptor.dart';

class HttpClient {
  final Dio dio;
  HttpClient()
      : dio = Dio(BaseOptions(baseUrl: AppConsts.apiURL))
          ..interceptors.add(TokenInterceptor());
}
