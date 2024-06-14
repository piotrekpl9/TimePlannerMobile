import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:go_router/go_router.dart';
import 'package:time_planner_mobile/infrastructure/authentication/model/auth_status.dart';
import 'package:time_planner_mobile/presentation/authentication/bloc/authentication_bloc.dart';
import 'package:time_planner_mobile/presentation/authentication/model/signin_data.dart';
import 'package:time_planner_mobile/presentation/schedule/schedule_screen.dart';
import 'package:time_planner_mobile/presentation/common/app_colors.dart';
import 'package:time_planner_mobile/presentation/common/widgets/generic_form_field.dart';
import 'package:time_planner_mobile/presentation/common/widgets/main_button.dart';
import 'package:time_planner_mobile/presentation/common/widgets/scaffold/start_scaffold.dart';

class SignInScreen extends StatefulWidget {
  static String path = "/signIn";
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  late FocusNode _passwordFocusNode;

  @override
  void initState() {
    _passwordFocusNode = FocusNode();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthenticationBloc, AuthenticationState>(
      bloc: context.read<AuthenticationBloc>(),
      listener: (context, state) {
        if (state.authStatus == AuthStatus.authenticated) {
          Fluttertoast.showToast(
              msg: "Sign-In Successful",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.green,
              textColor: Colors.white,
              fontSize: 16.0);
          context.go(ScheduleScreen.path);
        }
      },
      child: StartScaffold(
        child: Padding(
          padding: const EdgeInsets.all(40.0),
          child: SingleChildScrollView(
            child: SizedBox(
              height: MediaQuery.of(context).size.height,
              child: Column(
                children: [
                  Expanded(
                    flex: 5,
                    child: Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Expanded(
                            flex: 9,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  textAlign: TextAlign.start,
                                  "Sign in",
                                  style: TextStyle(
                                      color: AppColors.main, fontSize: 40),
                                ),
                                const SizedBox(
                                  height: 30,
                                ),
                                GenericFormField(
                                  hint: "Email",
                                  controller: _emailController,
                                  validator: (value) {
                                    if (value == null) {
                                      return "Value cannot be empty";
                                    }
                                    return null;
                                  },
                                  onFieldSubmitted: (p0) {
                                    _passwordFocusNode.requestFocus();
                                  },
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                GenericFormField(
                                  obscureText: true,
                                  hint: "Password",
                                  controller: _passwordController,
                                  focusNode: _passwordFocusNode,
                                  validator: (value) {
                                    if (value == null) {
                                      return "Value cannot be empty";
                                    }
                                    return null;
                                  },
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            flex: 2,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                MainButton(
                                  onPressed: () {
                                    if (_formKey.currentState!.validate()) {
                                      context.read<AuthenticationBloc>().add(
                                          SignInButtonPressed(
                                              signInData: SignInData(
                                                  email: _emailController.text,
                                                  password: _passwordController
                                                      .text)));
                                    }
                                  },
                                  child: Text(
                                    "Sign in",
                                    style:
                                        TextStyle(color: AppColors.secondary),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
