import 'package:flutter/material.dart';
import 'package:time_planner_mobile/presentation/common/app_colors.dart';

class MainButtonOutlined extends StatelessWidget {
  final Function()? onPressed;
  final Widget child;
  const MainButtonOutlined({super.key, this.onPressed, required this.child});

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
        onPressed: onPressed,
        style: OutlinedButton.styleFrom(
          padding: const EdgeInsets.all(19),
          side: BorderSide(
              color: AppColors.main, style: BorderStyle.solid, width: 3),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(50),
          ),
        ),
        child: child);
  }
}
