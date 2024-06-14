import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:time_planner_mobile/presentation/authentication/bloc/authentication_bloc.dart';
import 'package:time_planner_mobile/presentation/common/app_colors.dart';
import 'package:time_planner_mobile/presentation/common/widgets/generic_form_field.dart';
import 'package:time_planner_mobile/presentation/common/widgets/main_button.dart';
import 'package:time_planner_mobile/presentation/common/widgets/scaffold/bottom_navigation_bar/main_bottom_navigation_bar.dart';
import 'package:time_planner_mobile/presentation/common/widgets/scaffold/bottom_navigation_bar/navigation_bar_page.dart';
import 'package:time_planner_mobile/presentation/common/widgets/scaffold/main_app_bar.dart';
import 'package:time_planner_mobile/presentation/common/widgets/scaffold/main_scaffold.dart';
import 'package:time_planner_mobile/presentation/profile/bloc/user_profile_bloc.dart';
import 'package:time_planner_mobile/presentation/profile/widgets/change_password_dialog.dart';

class UserProfileScreen extends StatefulWidget {
  static String path = "/profile";
  const UserProfileScreen({super.key});

  @override
  State<UserProfileScreen> createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreen> {
  final emailController = TextEditingController();
  final nameController = TextEditingController();
  final surnameController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return MainScaffold(
      appBar: MainAppBar(
        title: Text(
          "User Profile",
          style: TextStyle(color: AppColors.main),
        ),
      ),
      bottomNavigationBar: const MainBottomNavigationBar(
        activeScreen: BottomNavigationBarPage.user,
      ),
      body: BlocBuilder<UserProfileBloc, UserProfileState>(
        bloc: context.read<UserProfileBloc>(),
        builder: (context, state) {
          if (state.status == UserProfileStatus.idle) {
            final user = state.user;
            if (user != null) {
              nameController.text = user.name;
              surnameController.text = user.surname;
              emailController.text = user.email;
            }
          }
          return Center(
            child: Padding(
              padding: const EdgeInsets.all(30.0),
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    color: AppColors.main,
                    width: 3,
                  ),
                  borderRadius: BorderRadius.circular(15),
                  color: AppColors.secondary,
                ),
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Icon(
                        Icons.person_outline,
                        size: 64,
                        color: AppColors.main,
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      GenericFormField(
                        controller: nameController,
                        enabled: false,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      GenericFormField(
                          controller: surnameController, enabled: false),
                      const SizedBox(
                        height: 20,
                      ),
                      GenericFormField(
                          controller: emailController, enabled: false),
                      const SizedBox(
                        height: 30,
                      ),
                      MainButton(
                        child: Text(
                          "Change password",
                          style: TextStyle(color: AppColors.secondary),
                        ),
                        onPressed: () {
                          showAdaptiveDialog(
                            context: context,
                            builder: (ctx) => BlocProvider.value(
                              value: context.read<UserProfileBloc>(),
                              child: const ChangePasswordDialog(),
                            ),
                          );
                        },
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      MainButton(
                        child: Text(
                          "Sign out",
                          style: TextStyle(color: AppColors.secondary),
                        ),
                        onPressed: () {
                          context
                              .read<AuthenticationBloc>()
                              .add(SignOutButtonPressed());
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
