import 'package:dio/dio.dart';
import 'package:time_planner_mobile/infrastructure/authentication/abstraction/authentication_service_abstraction.dart';

class StatusInterceptor extends Interceptor {
  final AuthenticationServiceAbstraction authenticationService;

  StatusInterceptor({required this.authenticationService});

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) async {
    if (response.statusCode == 401) {
      await authenticationService.signOut();
    }
    super.onResponse(response, handler);
  }
}
