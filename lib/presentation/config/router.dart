import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:time_planner_mobile/di_container.dart';
import 'package:time_planner_mobile/domain/task/task_repository_abstraction.dart';
import 'package:time_planner_mobile/domain/task/task_service_abstraction.dart';
import 'package:time_planner_mobile/infrastructure/authentication/abstraction/authentication_service_abstraction.dart';
import 'package:time_planner_mobile/presentation/authentication/sign_in_screen.dart';
import 'package:time_planner_mobile/presentation/schedule/bloc/calendar_bloc.dart';
import 'package:time_planner_mobile/presentation/schedule/schedule_screen.dart';
import 'package:time_planner_mobile/presentation/start/start_screen.dart';
import 'package:time_planner_mobile/presentation/signup/bloc/sign_up_bloc.dart';
import 'package:time_planner_mobile/presentation/signup/sign_up_screen.dart';

GoRouter setupRouter() {
  return GoRouter(
    restorationScopeId: 'router',
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) => const StartScreen(),
      ),
      GoRoute(
        path: SignInScreen.path,
        builder: (context, state) => const SignInScreen(),
      ),
      GoRoute(
        path: ScheduleScreen.path,
        builder: (context, state) => BlocProvider(
          create: (context) => CalendarBloc(
            taskService: diContainer.get<TaskServiceAbstraction>(),
            taskRepository: diContainer.get<TaskRepositoryAbstraction>(),
          )..add(UserEnteredScreenEvent()),
          child: const ScheduleScreen(),
        ),
      ),
      GoRoute(
        path: SignUpScreen.path,
        builder: (context, state) => BlocProvider(
          create: (context) => SignUpBloc(
              authenticationService:
                  diContainer.get<AuthenticationServiceAbstraction>()),
          child: const SignUpScreen(),
        ),
      ),
    ],
  );
}
