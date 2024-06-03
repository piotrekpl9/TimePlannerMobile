import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:time_planner_mobile/presentation/authentication/bloc/authentication_bloc.dart';
import 'package:time_planner_mobile/presentation/authentication/sign_in_screen.dart';
import 'package:time_planner_mobile/presentation/signup/sign_up_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(40.0),
            child: BlocBuilder<AuthenticationBloc, AuthenticationState>(
              builder: (context, state) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    ElevatedButton(
                      onPressed: state.authStatus != AuthStatus.authenticated
                          ? () {
                              context.push(SignInScreen.path);
                            }
                          : null,
                      child: const Text("SignIn"),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    ElevatedButton(
                      onPressed: state.authStatus != AuthStatus.authenticated
                          ? () {
                              context.push(SignUpScreen.path);
                            }
                          : null,
                      child: const Text("SignUp"),
                    ),
                  ],
                );
              },
            ),
          ),
        ));
  }
}
