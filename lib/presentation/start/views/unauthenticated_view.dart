import 'package:go_router/go_router.dart';
import 'package:flutter/material.dart';
import 'package:time_planner_mobile/presentation/authentication/sign_in_screen.dart';
import 'package:time_planner_mobile/presentation/common/app_colors.dart';
import 'package:time_planner_mobile/presentation/common/widgets/main_button.dart';
import 'package:time_planner_mobile/presentation/common/widgets/main_button_outlined.dart';
import 'package:time_planner_mobile/presentation/signup/sign_up_screen.dart';

class UnauthenticatedView extends StatelessWidget {
  const UnauthenticatedView({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Expanded(
          flex: 5,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Time Planner",
                style: TextStyle(color: AppColors.main, fontSize: 40),
              ),
              Text(
                "Work In Progress",
                style: TextStyle(color: AppColors.main, fontSize: 16),
              ),
            ],
          ),
        ),
        Expanded(
          flex: 3,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              MainButtonOutlined(
                onPressed: () {
                  context.push(SignInScreen.path);
                },
                child: Text(
                  "Sign In",
                  style: TextStyle(color: AppColors.main),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              MainButton(
                onPressed: () {
                  context.push(SignUpScreen.path);
                },
                child: Text(
                  "Sign Up",
                  style: TextStyle(color: AppColors.secondary),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
