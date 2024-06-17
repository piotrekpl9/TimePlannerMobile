import 'package:time_planner_mobile/domain/common/generic_error_details.dart';

enum ServiceErrorStatus { applicationError, serverError, communicationError }

class ServiceError {
  final ServiceErrorStatus status;
  final GenericErrorDetails? errorDetails;

  ServiceError({required this.status, required this.errorDetails});
}
