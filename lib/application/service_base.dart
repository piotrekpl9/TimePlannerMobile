import 'package:either_dart/either.dart';
import 'package:time_planner_mobile/domain/common/repository_error.dart';
import 'package:time_planner_mobile/domain/common/service_error.dart';

class ServiceBase {
  Left<ServiceError, T> handleError<T>(RepositoryError error) {
    switch (error.status) {
      case RepositoryErrorStatus.connectionError:
        return Left(ServiceError(
            errorDetails: error.errorDetails,
            status: ServiceErrorStatus.communicationError));

      case RepositoryErrorStatus.requestError:
        return Left(ServiceError(
            errorDetails: error.errorDetails,
            status: ServiceErrorStatus.communicationError));

      case RepositoryErrorStatus.serverError:
        return Left(ServiceError(
            errorDetails: error.errorDetails,
            status: ServiceErrorStatus.serverError));

      case RepositoryErrorStatus.internalError:
        return Left(ServiceError(
            errorDetails: error.errorDetails,
            status: ServiceErrorStatus.applicationError));
    }
  }
}
