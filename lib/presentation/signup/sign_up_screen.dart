import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:time_planner_mobile/presentation/common/app_colors.dart';
import 'package:time_planner_mobile/presentation/common/widgets/generic_form_field.dart';
import 'package:time_planner_mobile/presentation/common/widgets/main_button.dart';
import 'package:time_planner_mobile/presentation/common/widgets/start_scaffold.dart';
import 'package:time_planner_mobile/presentation/signup/bloc/sign_up_bloc.dart';
import 'package:time_planner_mobile/presentation/signup/signup_data.dart';

class SignUpScreen extends StatefulWidget {
  static String path = "/signUp";
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _surnameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  late FocusNode _surnameFocusNode;
  late FocusNode _emailFocusNode;
  late FocusNode _passwordFocusNode;

  @override
  void initState() {
    _surnameFocusNode = FocusNode();
    _emailFocusNode = FocusNode();
    _passwordFocusNode = FocusNode();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<SignUpBloc, SignUpState>(
      bloc: context.read<SignUpBloc>(),
      listener: (context, state) {
        if (state.status == SignUpStatus.success) {
          ScaffoldMessenger.of(context)
              .showSnackBar(const SnackBar(content: Text("SignUp Successful")));
          context.pop();
        }
      },
      child: StartScaffold(
          child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 40),
        child: SingleChildScrollView(
          child: SizedBox(
            height: MediaQuery.of(context).size.height,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Spacer(
                  flex: 2,
                ),
                Text(
                  textAlign: TextAlign.start,
                  "Sign up",
                  style: TextStyle(color: AppColors.main, fontSize: 40),
                ),
                Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      const SizedBox(
                        height: 30,
                      ),
                      GenericFormField(
                        hint: "Name",
                        controller: _nameController,
                        validator: (value) {
                          if (value == null) {
                            return "Value cannot be empty";
                          }
                          return null;
                        },
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      GenericFormField(
                        hint: "Surname",
                        controller: _surnameController,
                        focusNode: _surnameFocusNode,
                        validator: (value) {
                          if (value == null) {
                            return "Value cannot be empty";
                          }
                          return null;
                        },
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      GenericFormField(
                        hint: "Email",
                        controller: _emailController,
                        focusNode: _emailFocusNode,
                        validator: (value) {
                          if (value == null) {
                            return "Value cannot be empty";
                          }
                          return null;
                        },
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      GenericFormField(
                        hint: "Password",
                        obscureText: true,
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
                Spacer(),
                MainButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      context.read<SignUpBloc>().add(SignUpButtonPressed(
                          signUpData: SignUpData(
                              name: _nameController.text,
                              surname: _surnameController.text,
                              email: _emailController.text,
                              password: _passwordController.text)));
                    }
                  },
                  child: Text(
                    "Sign up",
                    style: TextStyle(color: AppColors.secondary),
                  ),
                ),
                SizedBox(
                  height: 40,
                )
              ],
            ),
          ),
        ),
      )),
    );
  }
}
