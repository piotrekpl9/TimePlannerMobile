import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:time_planner_mobile/presentation/common/app_colors.dart';
import 'package:time_planner_mobile/presentation/common/widgets/scaffold/bottom_navigation_bar/navigation_bar_page.dart';
import 'package:time_planner_mobile/presentation/group/group_screen.dart';
import 'package:time_planner_mobile/presentation/profile/user_profile_screen.dart';
import 'package:time_planner_mobile/presentation/schedule/schedule_screen.dart';

class MainBottomNavigationBar extends StatelessWidget {
  final BottomNavigationBarPage activeScreen;
  const MainBottomNavigationBar({super.key, required this.activeScreen});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: false,
      child: BottomAppBar(
        height: 60,
        color: AppColors.main,
        padding: const EdgeInsets.all(0),
        child: LayoutBuilder(builder: (context, constraints) {
          return Container(
            padding: const EdgeInsets.all(5),
            color: AppColors.main,
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Expanded(
                  child: IconButton(
                    icon: Icon(
                      Icons.person,
                      color: activeScreen == BottomNavigationBarPage.user
                          ? const Color(0xFF9EB6C2)
                          : Colors.black,
                    ),
                    onPressed: () {
                      if (activeScreen != BottomNavigationBarPage.user) {
                        context.go(
                          UserProfileScreen.path,
                        );
                      }
                    },
                  ),
                ),
                Expanded(
                  child: IconButton(
                    icon: Icon(
                      Icons.calendar_month,
                      color: activeScreen == BottomNavigationBarPage.schedule
                          ? const Color(0xFF9EB6C2)
                          : Colors.black,
                    ),
                    onPressed: () {
                      if (activeScreen != BottomNavigationBarPage.schedule) {
                        context.go(ScheduleScreen.path);
                      }
                    },
                  ),
                ),
                Expanded(
                  child: IconButton(
                    icon: Icon(
                      Icons.people,
                      color: activeScreen == BottomNavigationBarPage.group
                          ? const Color(0xFF9EB6C2)
                          : Colors.black,
                    ),
                    onPressed: () {
                      if (activeScreen != BottomNavigationBarPage.group) {
                        context.go(
                          GroupScreen.path,
                        );
                      }
                    },
                  ),
                ),
              ],
            ),
          );
        }),
      ),
    );
  }
}
