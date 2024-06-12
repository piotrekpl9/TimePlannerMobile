import 'package:flutter/material.dart';
import 'package:time_planner_mobile/presentation/common/app_colors.dart';

class GenericFormField extends StatelessWidget {
  final TextEditingController controller;
  final String? Function(String?)? validator;
  final Function(String?)? onFieldSubmitted;
  final String? hint;
  final bool? obscureText;
  final FocusNode? focusNode;
  final bool? enabled;
  const GenericFormField(
      {super.key,
      required this.controller,
      this.obscureText,
      this.enabled,
      this.onFieldSubmitted,
      this.validator,
      this.focusNode,
      this.hint});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      enabled: enabled ?? true,
      obscureText: obscureText ?? false,
      cursorColor: AppColors.main,
      style: TextStyle(
          color: AppColors.main,
          fontSize: 18,
          decoration: null,
          decorationStyle: null,
          textBaseline: null),
      decoration: InputDecoration(
          hintText: hint,
          hintStyle: TextStyle(color: AppColors.main),
          contentPadding: const EdgeInsets.all(15),
          disabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(
                  color: Color.fromARGB(255, 164, 155, 135), width: 3)),
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
      onFieldSubmitted: onFieldSubmitted,
      validator: validator,
      focusNode: focusNode,
    );
  }
}
