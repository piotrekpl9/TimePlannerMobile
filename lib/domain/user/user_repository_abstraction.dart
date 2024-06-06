import 'package:time_planner_mobile/domain/user/model/update_password_dto.dart';

abstract class UserRepositoryAbstraction {
  Future<bool> updateUserPassword(PasswordUpdateRequest dto);
}
