import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:time_planner_mobile/di_container.dart';
import 'package:time_planner_mobile/infrastructure/authentication/model/auth_status.dart';
import 'package:time_planner_mobile/presentation/authentication/bloc/authentication_bloc.dart';
import 'package:time_planner_mobile/presentation/authentication/sign_in_screen.dart';
import 'package:time_planner_mobile/presentation/config/router.dart';
import 'package:time_planner_mobile/presentation/signup/sign_up_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  setupDependencyInjectionContainer();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});
  final GoRouter router = setupRouter();
  @override
  Widget build(BuildContext context) {
    return BlocProvider<AuthenticationBloc>.value(
      value: diContainer.get<AuthenticationBloc>()..add(ApplicationStarted()),
      child: BlocListener<AuthenticationBloc, AuthenticationState>(
        listener: (context, state) {
          if (state.authStatus != AuthStatus.authenticated) {
            var currentLocation =
                router.routerDelegate.currentConfiguration.uri.toString();

            if (currentLocation != SignInScreen.path &&
                currentLocation != SignUpScreen.path) {
              router.go("/");
            }
          }
        },
        child: MaterialApp.router(
          restorationScopeId: 'root',
          title: 'TimePlanner Demo',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            fontFamily: 'Montserrat',
            useMaterial3: true,
          ),
          routerConfig: router,
        ),
      ),
    );
  }
}
