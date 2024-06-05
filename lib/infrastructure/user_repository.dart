import 'package:time_planner_mobile/domain/user/model/update_password_dto.dart';
import 'package:time_planner_mobile/domain/user/user_repository_abstraction.dart';
import 'package:time_planner_mobile/infrastructure/common/http_client/http_client.dart';

class UserRepository implements UserRepositoryAbstraction {
  final HttpClient httpClient;

  UserRepository({required this.httpClient});

  @override
  Future<bool> updateUserPassword(PasswordUpdateRequest dto) async {
    try {
      var result =
          await httpClient.dio.put("api/user/update-password", data: dto);
      return result.statusCode == 200;
    } catch (e) {
      return false;
    }
  }
}
