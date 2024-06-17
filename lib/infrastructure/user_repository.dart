import 'package:either_dart/either.dart';
import 'package:time_planner_mobile/domain/common/generic_error_details.dart';
import 'package:time_planner_mobile/domain/common/repository_error.dart';
import 'package:time_planner_mobile/domain/user/model/update_password_dto.dart';
import 'package:time_planner_mobile/domain/user/model/user.dart';
import 'package:time_planner_mobile/domain/user/user_repository_abstraction.dart';
import 'package:time_planner_mobile/infrastructure/common/http_client/http_client.dart';

class UserRepository implements UserRepositoryAbstraction {
  final HttpClient httpClient;

  UserRepository({required this.httpClient});

  @override
  Future<Either<RepositoryError, bool>> updateUserPassword(
      PasswordUpdateRequest dto) async {
    try {
      var result =
          await httpClient.dio.put("api/user/update-password", data: dto);
      if (result.statusCode != 200) {
        return Left(RepositoryError(
            status: RepositoryErrorStatus.requestError,
            errorDetails: GenericErrorDetails.fromJson(result.data)));
      }
      return const Right(true);
    } catch (e) {
      return Left(RepositoryError(status: RepositoryErrorStatus.internalError));
    }
  }

  @override
  Future<Either<RepositoryError, User>> getCurrentUser() async {
    try {
      var result = await httpClient.dio.get("api/user/");

      if (result.statusCode != 200) {
        return Left(RepositoryError(
            status: RepositoryErrorStatus.requestError,
            errorDetails: GenericErrorDetails.fromJson(result.data)));
      }
      if (result.data == null) {
        return Left(RepositoryError(status: RepositoryErrorStatus.serverError));
      }

      return Right(User.fromJson(result.data));
    } catch (e) {
      return Left(RepositoryError(status: RepositoryErrorStatus.internalError));
    }
  }
}
