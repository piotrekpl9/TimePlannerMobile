import 'package:go_router/go_router.dart';
import 'package:flutter/material.dart';
import 'package:time_planner_mobile/presentation/authentication/sign_in_screen.dart';
import 'package:time_planner_mobile/presentation/signup/sign_up_screen.dart';

class UnauthenticatedView extends StatelessWidget {
  const UnauthenticatedView({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        ElevatedButton(
          onPressed: () {
            context.push(SignInScreen.path);
          },
          child: const Text("Sign In"),
        ),
        const SizedBox(
          height: 20,
        ),
        ElevatedButton(
          onPressed: () {
            context.push(SignUpScreen.path);
          },
          child: const Text("Sign Up"),
        ),
      ],
    );
  }
}
