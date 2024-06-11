import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:time_planner_mobile/di_container.dart';
import 'package:time_planner_mobile/domain/group/group_repository_abstraction.dart';
import 'package:time_planner_mobile/domain/task/task_repository_abstraction.dart';
import 'package:time_planner_mobile/domain/task/task_service_abstraction.dart';
import 'package:time_planner_mobile/domain/user/user_repository_abstraction.dart';
import 'package:time_planner_mobile/domain/user/user_service_abstraction.dart';
import 'package:time_planner_mobile/infrastructure/authentication/abstraction/authentication_service_abstraction.dart';
import 'package:time_planner_mobile/presentation/authentication/sign_in_screen.dart';
import 'package:time_planner_mobile/presentation/group/bloc/group_bloc.dart';
import 'package:time_planner_mobile/presentation/group/group_screen.dart';
import 'package:time_planner_mobile/presentation/profile/bloc/user_profile_bloc.dart';
import 'package:time_planner_mobile/presentation/profile/user_profile_screen.dart';
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
        path: UserProfileScreen.path,
        pageBuilder: (context, state) {
          return CustomTransitionPage(
            key: state.pageKey,
            child: BlocProvider(
              create: (context) => UserProfileBloc(
                userService: diContainer.get<UserServiceAbstraction>(),
                userRepository: diContainer.get<UserRepositoryAbstraction>(),
              )..add(UserEnteredProfileScreenEvent()),
              child: const UserProfileScreen(),
            ),
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) {
              // Change the opacity of the screen using a Curve based on the the animation's
              // value
              return child;
            },
          );
        },
      ),
      GoRoute(
        path: GroupScreen.path,
        pageBuilder: (context, state) {
          return CustomTransitionPage(
            key: state.pageKey,
            child: BlocProvider(
              create: (context) => GroupBloc(
                  groupRepository:
                      diContainer.get<GroupRepositoryAbstraction>())
                ..add(UserEnteredGroupScreenEvent()),
              child: const GroupScreen(),
            ),
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) {
              // Change the opacity of the screen using a Curve based on the the animation's
              // value
              return child;
            },
          );
        },
      ),
      GoRoute(
        path: SignInScreen.path,
        builder: (context, state) => const SignInScreen(),
      ),
      GoRoute(
        path: ScheduleScreen.path,
        pageBuilder: (context, state) {
          return CustomTransitionPage(
            key: state.pageKey,
            child: BlocProvider(
              create: (context) => CalendarBloc(
                taskService: diContainer.get<TaskServiceAbstraction>(),
                taskRepository: diContainer.get<TaskRepositoryAbstraction>(),
              )..add(UserEnteredScreenEvent()),
              child: const ScheduleScreen(),
            ),
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) {
              // Change the opacity of the screen using a Curve based on the the animation's
              // value
              return child;
            },
          );
        },
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
