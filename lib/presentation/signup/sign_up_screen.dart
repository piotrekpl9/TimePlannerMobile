import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
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
      child: Scaffold(
          appBar: AppBar(),
          body: Padding(
            padding: const EdgeInsets.all(40.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      TextFormField(
                        controller: _nameController,
                        validator: (value) {
                          if (value == null) {
                            return "Value cannot be empty";
                          }
                          return null;
                        },
                      ),
                      TextFormField(
                        controller: _surnameController,
                        focusNode: _surnameFocusNode,
                        validator: (value) {
                          if (value == null) {
                            return "Value cannot be empty";
                          }
                          return null;
                        },
                      ),
                      TextFormField(
                        controller: _emailController,
                        focusNode: _emailFocusNode,
                        validator: (value) {
                          if (value == null) {
                            return "Value cannot be empty";
                          }
                          return null;
                        },
                      ),
                      TextFormField(
                        controller: _passwordController,
                        focusNode: _passwordFocusNode,
                        validator: (value) {
                          if (value == null) {
                            return "Value cannot be empty";
                          }
                          return null;
                        },
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      ElevatedButton(
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
                        child: const Text("Sign up"),
                      ),
                    ],
                  ),
                )
              ],
            ),
          )),
    );
  }
}
