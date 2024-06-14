import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:time_planner_mobile/presentation/common/app_colors.dart';
import 'package:time_planner_mobile/presentation/common/widgets/scaffold/bottom_navigation_bar/navigation_bar_page.dart';
import 'package:time_planner_mobile/presentation/common/widgets/scaffold/main_app_bar.dart';
import 'package:time_planner_mobile/presentation/common/widgets/scaffold/bottom_navigation_bar/main_bottom_navigation_bar.dart';
import 'package:time_planner_mobile/presentation/group/group_screen.dart';
import 'package:time_planner_mobile/presentation/profile/user_profile_screen.dart';

class MainScaffold extends StatelessWidget {
  final Widget body;
  final BottomNavigationBarPage currentScreenCategory;
  const MainScaffold(
      {super.key, required this.body, required this.currentScreenCategory});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
            image: AssetImage("assets/background2.png"), fit: BoxFit.cover),
      ),
      child: Scaffold(
        extendBodyBehindAppBar: true,
        appBar: MainAppBar(
          title: Text(
            "Schedule",
            style: TextStyle(color: AppColors.main),
          ),
        ),
        backgroundColor: const Color.fromARGB(37, 0, 0, 0),
        extendBody: true,
        bottomNavigationBar: MainBottomNavigationBar(
          activeScreen: currentScreenCategory,
        ),
        resizeToAvoidBottomInset: false,
        body: body,
      ),
    );
  }
}
