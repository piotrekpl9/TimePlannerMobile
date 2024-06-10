import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:time_planner_mobile/di_container.dart';
import 'package:time_planner_mobile/presentation/authentication/bloc/authentication_bloc.dart';
import 'package:time_planner_mobile/presentation/config/router.dart';

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
      child: MaterialApp.router(
        restorationScopeId: 'root',
        title: 'TimePlanner Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          fontFamily: 'AvenirNext',
          useMaterial3: true,
        ),
        routerConfig: router,
      ),
    );
  }
}
