import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:time_planner_mobile/di_container.dart';
import 'package:time_planner_mobile/domain/task/task_repository_abstraction.dart';
import 'package:time_planner_mobile/domain/task/task_service_abstraction.dart';
import 'package:time_planner_mobile/infrastructure/authentication/abstraction/authentication_service_abstraction.dart';
import 'package:time_planner_mobile/infrastructure/authentication/model/auth_status.dart';
import 'package:time_planner_mobile/presentation/authentication/bloc/authentication_bloc.dart';
import 'package:time_planner_mobile/presentation/authentication/sign_in_screen.dart';
import 'package:time_planner_mobile/presentation/calendar/bloc/calendar_bloc.dart';
import 'package:time_planner_mobile/presentation/calendar/calendar_screen.dart';
import 'package:time_planner_mobile/presentation/start/start_screen.dart';
import 'package:time_planner_mobile/presentation/signup/bloc/sign_up_bloc.dart';
import 'package:time_planner_mobile/presentation/signup/sign_up_screen.dart';

GoRouter setupRouter(BuildContext context) {
  AuthenticationBloc authBloc = diContainer.get<AuthenticationBloc>();
  return GoRouter(
    redirect: (context, state) {
      if (authBloc.state.authStatus != AuthStatus.authenticated &&
          authBloc.state.authStatus != AuthStatus.unknown) {
        if (state.matchedLocation == SignInScreen.path ||
            state.matchedLocation == SignUpScreen.path) {
          return null;
        }
        return "/";
      }
      return null;
    },
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
            taskService: diContainer.get<TaskServiceAbstraction>(),
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
}
