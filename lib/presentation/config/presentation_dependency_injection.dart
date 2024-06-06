import 'package:get_it/get_it.dart';
import 'package:time_planner_mobile/domain/group/group_repository_abstraction.dart';
import 'package:time_planner_mobile/infrastructure/authentication/abstraction/authentication_repository_abstraction.dart';
import 'package:time_planner_mobile/infrastructure/authentication/abstraction/authentication_service_abstraction.dart';
import 'package:time_planner_mobile/presentation/authentication/bloc/authentication_bloc.dart';

void setupPresentationDependencyInjection(GetIt diContainer) {
  var authBloc = AuthenticationBloc(
      groupRepository: diContainer.get<GroupRepositoryAbstraction>(),
      authenticationService:
          diContainer.get<AuthenticationServiceAbstraction>(),
      authenticationRepository:
          diContainer.get<AuthenticationRepositoryAbstraction>())
    ..add(ApplicationStarted());

  diContainer.registerLazySingleton<AuthenticationBloc>(() => authBloc);
}
