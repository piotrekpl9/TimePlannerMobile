import 'package:dio/dio.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:time_planner_mobile/di_container.dart';
import 'package:time_planner_mobile/infrastructure/authentication/abstraction/authentication_repository_abstraction.dart';
import 'package:time_planner_mobile/infrastructure/authentication/abstraction/secure_storage_dao_abstraction.dart';

class TokenInterceptor extends Interceptor {
  final tokenStorageDao = diContainer.get<SecureStorageDaoAbstraction>();

  @override
  Future<void> onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    final token = await tokenStorageDao.read("jwtToken");

    if (token != null) {
      try {
        final isTokenExpired = JwtDecoder.isExpired(token);

        if (isTokenExpired) {
          //TODO add logger
          return super.onRequest(options, handler);
        }
      } on Exception catch (e) {
        //TODO add logger
        return super.onRequest(options, handler);
      }

      options.headers.addAll({"Authorization": "Bearer $token"});
    } else {
      //TODO add logger
    }

    return super.onRequest(options, handler);
  }
}
