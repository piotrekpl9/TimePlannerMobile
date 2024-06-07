import 'package:flutter/material.dart';
import 'package:time_planner_mobile/presentation/common/app_colors.dart';

class MainButton extends StatelessWidget {
  final Function()? onPressed;
  final Widget child;
  const MainButton({super.key, this.onPressed, required this.child});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.all(19),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
            backgroundColor: AppColors.main),
        child: child);
  }
}
