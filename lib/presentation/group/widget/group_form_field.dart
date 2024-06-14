import 'package:flutter/material.dart';
import 'package:time_planner_mobile/presentation/common/app_colors.dart';

class GroupFormField extends StatelessWidget {
  final TextEditingController controller;
  final String hint;
  const GroupFormField(
      {super.key, required this.hint, required this.controller});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      cursorColor: AppColors.main,
      style: TextStyle(
          color: AppColors.main,
          fontSize: 20,
          decoration: null,
          decorationStyle: null,
          textBaseline: null),
      decoration: InputDecoration(
          enabled: false,
          hintText: hint,
          hintStyle: TextStyle(color: AppColors.main),
          contentPadding: const EdgeInsets.all(15),
          disabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(color: AppColors.main, width: 3)),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(color: AppColors.main, width: 3)),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(color: AppColors.main, width: 3)),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(color: AppColors.main, width: 3))),
      controller: controller,
    );
  }
}
