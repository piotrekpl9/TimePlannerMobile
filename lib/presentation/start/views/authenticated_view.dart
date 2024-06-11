import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:time_planner_mobile/presentation/authentication/bloc/authentication_bloc.dart';
import 'package:time_planner_mobile/presentation/schedule/schedule_screen.dart';
import 'package:time_planner_mobile/presentation/common/app_colors.dart';
import 'package:time_planner_mobile/presentation/common/widgets/main_button.dart';

class AuthenticatedView extends StatelessWidget {
  const AuthenticatedView({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        MainButton(
          onPressed: () {
            context.go(ScheduleScreen.path);
          },
          child: Text(
            "Calendar Screen",
            style: TextStyle(color: AppColors.secondary),
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        MainButton(
          onPressed: () {
            context.read<AuthenticationBloc>().add(SignOutButtonPressed());
          },
          child: Text(
            "Sign Out",
            style: TextStyle(color: AppColors.secondary),
          ),
        ),
      ],
    );
  }
}
