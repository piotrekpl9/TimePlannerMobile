import 'package:flutter/material.dart';
import 'package:time_planner_mobile/presentation/common/app_colors.dart';
import 'package:time_planner_mobile/presentation/common/widgets/scaffold/bottom_navigation_bar/main_bottom_navigation_bar.dart';
import 'package:time_planner_mobile/presentation/common/widgets/scaffold/bottom_navigation_bar/navigation_bar_page.dart';
import 'package:time_planner_mobile/presentation/common/widgets/scaffold/main_app_bar.dart';
import 'package:time_planner_mobile/presentation/common/widgets/scaffold/main_scaffold.dart';
import 'package:time_planner_mobile/presentation/group/views/group_view.dart';

class GroupScreen extends StatefulWidget {
  static String path = "/group";
  const GroupScreen({super.key});

  @override
  State<GroupScreen> createState() => _GroupScreenState();
}

class _GroupScreenState extends State<GroupScreen> {
  bool groupView = true;
  @override
  Widget build(BuildContext context) {
    return MainScaffold(
      appBar: MainAppBar(
        title: Text(
          "User Group",
          style: TextStyle(color: AppColors.main),
        ),
      ),
      bottomNavigationBar: const MainBottomNavigationBar(
        activeScreen: BottomNavigationBarPage.group,
      ),
      body: const SafeArea(
        child: Padding(
          padding: EdgeInsets.all(30.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.min,
            children: [Expanded(child: GroupView())],
          ),
        ),
      ),
    );
  }
}
