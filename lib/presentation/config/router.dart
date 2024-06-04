import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:time_planner_mobile/di_container.dart';
import 'package:time_planner_mobile/infrastructure/authentication/abstraction/authentication_service_abstraction.dart';
import 'package:time_planner_mobile/infrastructure/authentication/model/auth_status.dart';
import 'package:time_planner_mobile/presentation/authentication/bloc/authentication_bloc.dart';
import 'package:time_planner_mobile/presentation/authentication/sign_in_screen.dart';
import 'package:time_planner_mobile/presentation/home_screen.dart';
import 'package:time_planner_mobile/presentation/signup/bloc/sign_up_bloc.dart';
import 'package:time_planner_mobile/presentation/signup/sign_up_screen.dart';

final router = GoRouter(
  redirect: (context, state) {
    if (context.read<AuthenticationBloc>().state.authStatus !=
        AuthStatus.authenticated) {
      return "/";
    }
    return null;
  },
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const HomeScreen(),
    ),
    GoRoute(
      path: SignInScreen.path,
      builder: (context, state) => const SignInScreen(),
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
