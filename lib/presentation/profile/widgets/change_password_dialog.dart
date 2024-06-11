import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:time_planner_mobile/presentation/common/app_colors.dart';
import 'package:time_planner_mobile/presentation/common/widgets/generic_form_field.dart';
import 'package:time_planner_mobile/presentation/common/widgets/main_button.dart';
import 'package:time_planner_mobile/presentation/profile/bloc/user_profile_bloc.dart';

class ChangePasswordDialog extends StatefulWidget {
  const ChangePasswordDialog({super.key});

  @override
  State<ChangePasswordDialog> createState() => _ChangePasswordDialogState();
}

class _ChangePasswordDialogState extends State<ChangePasswordDialog> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _oldPasswordController = TextEditingController();
  final TextEditingController _newPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: AppColors.secondary,
      shape: RoundedRectangleBorder(
          side: BorderSide(
            color: AppColors.main,
            width: 3,
          ),
          borderRadius: BorderRadius.circular(15)),
      child: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  size: 54,
                  Icons.edit_note,
                  color: AppColors.main,
                ),
                const SizedBox(
                  height: 10,
                ),
                GenericFormField(
                  obscureText: true,
                  hint: "Current password",
                  controller: _oldPasswordController,
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
                  obscureText: true,
                  hint: "New password",
                  controller: _newPasswordController,
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
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 20.0, vertical: 10),
                  child: MainButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          context.read<UserProfileBloc>().add(
                                UserChangePasswordPressed(
                                    oldPassword: _oldPasswordController.text,
                                    newPassword: _newPasswordController.text),
                              );
                          if (context.mounted) {
                            context.pop();
                          }
                        }
                      },
                      child: Text(
                        "Submit",
                        style: TextStyle(color: AppColors.secondary),
                      )),
                )
              ],
            ),
          )),
    );
  }
}
