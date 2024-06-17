import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:time_planner_mobile/presentation/common/app_colors.dart';
import 'package:time_planner_mobile/presentation/common/widgets/scaffold/bottom_navigation_bar/main_bottom_navigation_bar.dart';
import 'package:time_planner_mobile/presentation/common/widgets/scaffold/bottom_navigation_bar/navigation_bar_page.dart';
import 'package:time_planner_mobile/presentation/common/widgets/scaffold/main_app_bar.dart';
import 'package:time_planner_mobile/presentation/common/widgets/scaffold/main_scaffold.dart';
import 'package:time_planner_mobile/presentation/group/bloc/group_bloc.dart';
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
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(30.0),
          child: BlocListener<GroupBloc, GroupState>(
            listener: (context, state) {
              if (state.status == GroupBlocStatus.error) {
                Fluttertoast.showToast(
                    msg: state.error?.description ?? "Unknown error occured!",
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.BOTTOM,
                    timeInSecForIosWeb: 1,
                    backgroundColor: Colors.red,
                    textColor: Colors.white,
                    fontSize: 16.0);
              }
            },
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisSize: MainAxisSize.min,
              children: [Expanded(child: GroupView())],
            ),
          ),
        ),
      ),
    );
  }
}
