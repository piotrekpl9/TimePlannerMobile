import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:time_planner_mobile/di_container.dart';
import 'package:time_planner_mobile/domain/task/task_repository_abstraction.dart';
import 'package:time_planner_mobile/infrastructure/authentication/abstraction/authentication_service_abstraction.dart';
import 'package:time_planner_mobile/presentation/authentication/sign_in_screen.dart';
import 'package:time_planner_mobile/presentation/calendar/bloc/calendar_bloc.dart';
import 'package:time_planner_mobile/presentation/calendar/callendar_screen.dart';
import 'package:time_planner_mobile/presentation/start/start_screen.dart';
import 'package:time_planner_mobile/presentation/signup/bloc/sign_up_bloc.dart';
import 'package:time_planner_mobile/presentation/signup/sign_up_screen.dart';

final router = GoRouter(
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
      path: CalendarScreen.path,
      builder: (context, state) => BlocProvider(
        create: (context) => CalendarBloc(
          taskRepository: diContainer.get<TaskRepositoryAbstraction>(),
        )..add(UserEnteredScreenEvent()),
        child: const CalendarScreen(),
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
