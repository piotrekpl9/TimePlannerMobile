import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:go_router/go_router.dart';
import 'package:time_planner_mobile/presentation/common/app_colors.dart';
import 'package:time_planner_mobile/presentation/common/widgets/scaffold/bottom_navigation_bar/main_bottom_navigation_bar.dart';
import 'package:time_planner_mobile/presentation/common/widgets/scaffold/bottom_navigation_bar/navigation_bar_page.dart';
import 'package:time_planner_mobile/presentation/common/widgets/scaffold/main_app_bar.dart';
import 'package:time_planner_mobile/presentation/common/widgets/scaffold/main_scaffold.dart';
import 'package:time_planner_mobile/presentation/group/bloc/group_bloc.dart';
import 'package:time_planner_mobile/presentation/group/views/invitations_view.dart';
import 'package:time_planner_mobile/presentation/profile/user_profile_screen.dart';
import 'package:time_planner_mobile/presentation/schedule/schedule_screen.dart';

class InvitationsScreen extends StatefulWidget {
  static String path = "/invitations";
  const InvitationsScreen({super.key});

  @override
  State<InvitationsScreen> createState() => _InvitationsScreenState();
}

class _InvitationsScreenState extends State<InvitationsScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocListener<GroupBloc, GroupState>(
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
      child: MainScaffold(
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
              children: [
                Expanded(child: InvitationsView()),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
