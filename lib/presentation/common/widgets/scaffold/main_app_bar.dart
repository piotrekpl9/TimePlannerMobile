import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:time_planner_mobile/presentation/common/app_colors.dart';

class MainAppBar extends StatelessWidget implements PreferredSizeWidget {
  final Widget? title;
  const MainAppBar({super.key, this.title});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: Color.fromARGB(162, 0, 53, 94)),
      centerTitle: true,
      backgroundColor: Colors.transparent,
      title: title,
    );
  }

  @override
  Size get preferredSize => AppBar().preferredSize;
}
