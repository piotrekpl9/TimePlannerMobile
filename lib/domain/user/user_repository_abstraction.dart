import 'package:time_planner_mobile/domain/user/model/update_password_dto.dart';
import 'package:time_planner_mobile/domain/user/model/user.dart';

abstract class UserRepositoryAbstraction {
  Future<bool> updateUserPassword(PasswordUpdateRequest dto);
  Future<User?> getCurrentUser();
}
