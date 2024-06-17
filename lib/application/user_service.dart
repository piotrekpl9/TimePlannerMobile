import 'package:either_dart/either.dart';
import 'package:time_planner_mobile/application/service_base.dart';
import 'package:time_planner_mobile/domain/common/service_error.dart';
import 'package:time_planner_mobile/domain/user/model/update_password_dto.dart';
import 'package:time_planner_mobile/domain/user/user_repository_abstraction.dart';
import 'package:time_planner_mobile/domain/user/user_service_abstraction.dart';

class UserService extends ServiceBase implements UserServiceAbstraction {
  final UserRepositoryAbstraction userRepository;

  UserService({required this.userRepository});

  @override
  Future<Either<ServiceError, bool>> updateUserPassword(
      PasswordUpdateRequest dto) async {
    var result = await userRepository.updateUserPassword(dto);
    return handleGenericResponse<bool>(result);
  }
}
