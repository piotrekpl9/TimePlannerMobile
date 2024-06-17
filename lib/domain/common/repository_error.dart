import 'package:time_planner_mobile/domain/common/generic_error_details.dart';

enum RepositoryErrorStatus {
  connectionError,
  requestError,
  serverError,
  internalError
}

class RepositoryError {
  final RepositoryErrorStatus status;
  final GenericErrorDetails? errorDetails;

  RepositoryError({required this.status, this.errorDetails});
}
