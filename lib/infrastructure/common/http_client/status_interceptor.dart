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

  @override
  void onError(DioError err, ErrorInterceptorHandler handler) async {
    // Check if the error is due to specific status codes
    if (err.response != null &&
        (err.response?.statusCode == 401 || err.response?.statusCode == 400)) {
      if (err.response?.statusCode == 401) {
        await authenticationService.signOut();
      }
      // If you don't want Dio to throw the error, you can call handler.resolve with a default Response.
      handler.resolve(Response(
        requestOptions: err.requestOptions,
        statusCode: err.response?.statusCode,
      ));
    } else {
      // If the error is not 401 or 400, pass it to the next handler
      handler.next(err);
    }
  }
}
