import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:time_planner_mobile/presentation/common/app_colors.dart';
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
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
            image: AssetImage("assets/background2.png"), fit: BoxFit.cover),
      ),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          systemOverlayStyle: const SystemUiOverlayStyle(
              statusBarColor: Color.fromARGB(162, 0, 53, 94)),
          centerTitle: true,
          backgroundColor: Colors.transparent,
          title: Text(
            "User Group",
            style: TextStyle(color: AppColors.main),
          ),
        ),
        backgroundColor: Colors.transparent,
        bottomNavigationBar: BottomAppBar(
          padding: const EdgeInsets.all(0),
          color: Colors.transparent,
          child: LayoutBuilder(builder: (context, constraints) {
            return Stack(
              alignment: AlignmentDirectional.bottomCenter,
              children: [
                Container(
                  padding: const EdgeInsets.all(5),
                  color: AppColors.main,
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      Expanded(
                        child: IconButton(
                          icon: const Icon(
                            Icons.person,
                            color: Colors.black,
                          ),
                          onPressed: () {
                            context.go(
                              UserProfileScreen.path,
                            );
                          },
                        ),
                      ),
                      Expanded(
                        child: IconButton(
                          icon: const Icon(
                            Icons.calendar_month,
                            color: Colors.black,
                          ),
                          onPressed: () {
                            context.go(
                              ScheduleScreen.path,
                            );
                          },
                        ),
                      ),
                      Expanded(
                        child: IconButton(
                          icon: const Icon(
                            Icons.people,
                            color: Color(0xFF9EB6C2),
                          ),
                          onPressed: () {},
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            );
          }),
        ),
        body: const Padding(
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
    );
  }
}
