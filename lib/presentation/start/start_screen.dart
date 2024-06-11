import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:time_planner_mobile/infrastructure/authentication/model/auth_status.dart';
import 'package:time_planner_mobile/presentation/authentication/bloc/authentication_bloc.dart';
import 'package:time_planner_mobile/presentation/schedule/schedule_screen.dart';
import 'package:time_planner_mobile/presentation/common/widgets/start_scaffold.dart';
import 'package:time_planner_mobile/presentation/start/views/authenticated_view.dart';
import 'package:time_planner_mobile/presentation/start/views/unauthenticated_view.dart';

class StartScreen extends StatelessWidget {
  const StartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return StartScaffold(
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(40.0),
          child: BlocConsumer<AuthenticationBloc, AuthenticationState>(
            listener: (context, state) {
              if (state.authStatus == AuthStatus.authenticated) {
                context.go(ScheduleScreen.path);
              }
            },
            builder: (context, state) {
              return state.authStatus != AuthStatus.authenticated
                  ? const UnauthenticatedView()
                  : const AuthenticatedView();
            },
          ),
        ),
      ),
    );
  }
}
