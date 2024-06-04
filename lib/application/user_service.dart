import 'package:time_planner_mobile/domain/user/model/update_password_dto.dart';
import 'package:time_planner_mobile/domain/user/user_repository_abstraction.dart';
import 'package:time_planner_mobile/domain/user/user_service_abstraction.dart';

class UserService implements UserServiceAbstraction {
  final UserRepositoryAbstraction userRepository;

  UserService({required this.userRepository});

  @override
  Future<bool> updateUserPassword(PasswordUpdateRequest dto) async {
    return userRepository.updateUserPassword(dto);
  }
}
