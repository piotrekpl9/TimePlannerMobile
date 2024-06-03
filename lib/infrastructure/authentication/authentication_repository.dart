import 'package:dio/dio.dart';
import 'package:time_planner_mobile/infrastructure/authentication/abstraction/authentication_repository_abstraction.dart';
import 'package:time_planner_mobile/infrastructure/authentication/abstraction/secure_storage_dao_abstraction.dart';
import 'package:time_planner_mobile/infrastructure/authentication/model/sign_in_dto.dart';
import 'package:time_planner_mobile/infrastructure/authentication/model/sign_up_dto.dart';
import 'package:time_planner_mobile/infrastructure/common/http_client.dart';

class AuthenticationRepository implements AuthenticationRepositoryAbstraction {
  final SecureStorageDaoAbstraction secureStorageDao;
  final HttpClient httpClient;

  AuthenticationRepository(
      {required this.secureStorageDao, required this.httpClient});

  @override
  Future<String?> getAccessToken() async {
    return await secureStorageDao.read("jwtToken");
  }

  @override
  Future<void> saveAccessToken(String token) async {
    await secureStorageDao.write("jwtToken", token);
  }

  @override
  Future<String?> signIn(SignInDto dto) async {
    try {
      var result = await httpClient.dio.post(
        "sign-in",
        data: dto,
        options: Options(
          headers: {
            Headers.contentTypeHeader:
                'application/json', // Set the MediaType here
          },
        ),
      );

      return result.data?["token"];
    } catch (e) {
      return null;
    }
  }

  @override
  Future<bool> signUp(SignUpDto dto) async {
    try {
      var result = await httpClient.dio.post(
        "sign-up",
        data: dto,
        options: Options(
          headers: {
            Headers.contentTypeHeader:
                'application/json', // Set the MediaType here
          },
        ),
      );

      return result.statusCode == 200;
    } catch (e) {
      return false;
    }
  }
}
