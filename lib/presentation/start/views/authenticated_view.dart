import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:time_planner_mobile/presentation/authentication/bloc/authentication_bloc.dart';

class AuthenticatedView extends StatelessWidget {
  const AuthenticatedView({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        ElevatedButton(
          onPressed: () {
            context.push();
          },
          child: const Text("Sign Out"),
        ),
        ElevatedButton(
          onPressed: () {
            context.read<AuthenticationBloc>().add(SignOutButtonPressed());
          },
          child: const Text("Sign Out"),
        ),
      ],
    );
  }
}
