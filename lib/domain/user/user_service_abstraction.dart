import 'package:either_dart/either.dart';
import 'package:time_planner_mobile/domain/common/service_error.dart';
import 'package:time_planner_mobile/domain/user/model/update_password_dto.dart';

abstract class UserServiceAbstraction {
  Future<Either<ServiceError, bool>> updateUserPassword(
      PasswordUpdateRequest dto);
}
