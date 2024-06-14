import 'package:flutter/material.dart';
import 'package:time_planner_mobile/presentation/common/app_colors.dart';

class MainFloatingActionButton extends StatelessWidget {
  final void Function()? onPressed;
  final Widget? child;
  const MainFloatingActionButton(
      {super.key, required this.onPressed, required this.child});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
          side: BorderSide(color: AppColors.main, width: 2)),
      backgroundColor: AppColors.secondary,
      onPressed: onPressed,
      heroTag: UniqueKey(),
      child: child,
    );
  }
}
