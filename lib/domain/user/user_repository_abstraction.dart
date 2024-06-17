import 'package:either_dart/either.dart';
import 'package:time_planner_mobile/domain/common/repository_error.dart';
import 'package:time_planner_mobile/domain/user/model/update_password_dto.dart';
import 'package:time_planner_mobile/domain/user/model/user.dart';

abstract class UserRepositoryAbstraction {
  Future<Either<RepositoryError, bool>> updateUserPassword(
      PasswordUpdateRequest dto);
  Future<Either<RepositoryError, User>> getCurrentUser();
}
