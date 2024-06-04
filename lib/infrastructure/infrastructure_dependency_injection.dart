import 'package:get_it/get_it.dart';
import 'package:time_planner_mobile/infrastructure/authentication/abstraction/authentication_repository_abstraction.dart';
import 'package:time_planner_mobile/infrastructure/authentication/abstraction/authentication_service_abstraction.dart';
import 'package:time_planner_mobile/infrastructure/authentication/abstraction/secure_storage_dao_abstraction.dart';
import 'package:time_planner_mobile/infrastructure/authentication/authentication_repository.dart';
import 'package:time_planner_mobile/infrastructure/authentication/authentication_service.dart';
import 'package:time_planner_mobile/infrastructure/authentication/secure_storage_dao.dart';
import 'package:time_planner_mobile/infrastructure/common/http_client.dart';
import 'package:time_planner_mobile/infrastructure/common/status_interceptor.dart';
import 'package:time_planner_mobile/infrastructure/common/token_interceptor.dart';

void setupInfrastructureDependencyInjection(GetIt diContainer) {
  var secureStorageDao = SecureStorageDao();

  diContainer.registerLazySingleton<SecureStorageDaoAbstraction>(
      () => secureStorageDao);

  var httpClient = HttpClient(secureStorageDao);
  var authRepo = AuthenticationRepository(
      secureStorageDao: secureStorageDao, httpClient: httpClient);
  var authService = AuthenticationService(authenticationRepository: authRepo);

  diContainer.registerLazySingleton<AuthenticationRepositoryAbstraction>(
      () => authRepo);

  diContainer.registerLazySingleton<AuthenticationServiceAbstraction>(
      () => authService);

  httpClient.dio
    ..interceptors.add(TokenInterceptor(secureStorageDao: secureStorageDao))
    ..interceptors.add(StatusInterceptor(authenticationService: authService));
}
