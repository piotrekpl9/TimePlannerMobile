import 'package:dio/dio.dart';
import 'package:time_planner_mobile/app_consts.dart';

import '../authentication/abstraction/secure_storage_dao_abstraction.dart';

class HttpClient {
  final SecureStorageDaoAbstraction secureStorageDao;

  final Dio dio;
  HttpClient(this.secureStorageDao)
      : dio = Dio(BaseOptions(baseUrl: AppConsts.apiURL))
          ..options = BaseOptions(
            headers: {
              Headers.contentTypeHeader:
                  'application/json', // Set the MediaType here
            },
          );

  //Add "addinterceptos"
}
