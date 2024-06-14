import 'package:flutter/material.dart';
import 'package:time_planner_mobile/presentation/common/app_colors.dart';

class GenericDateFormField extends StatelessWidget {
  final TextEditingController controller;
  final String? Function(String?)? validator;
  final void Function() onTap;
  final Function(String?)? onFieldSubmitted;
  final String? hint;
  final bool? enabled;
  final FocusNode? focusNode;
  const GenericDateFormField(
      {super.key,
      required this.controller,
      this.onFieldSubmitted,
      required this.onTap,
      this.validator,
      this.enabled,
      this.focusNode,
      this.hint});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      readOnly: true,
      enabled: enabled ?? true,
      onTap: onTap,
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
              borderSide: BorderSide(
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
