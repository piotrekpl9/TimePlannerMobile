import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:time_planner_mobile/presentation/common/app_colors.dart';
import 'package:time_planner_mobile/presentation/common/widgets/generic_form_field.dart';
import 'package:time_planner_mobile/presentation/group/views/group_view.dart';
import 'package:time_planner_mobile/presentation/group/views/invitations_view.dart';
import 'package:time_planner_mobile/presentation/profile/bloc/user_profile_bloc.dart';
import 'package:time_planner_mobile/presentation/profile/user_profile_screen.dart';
import 'package:time_planner_mobile/presentation/schedule/schedule_screen.dart';

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
              "User Profile",
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
                              context.go(UserProfileScreen.path);
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
                              context.go(ScheduleScreen.path);
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                  groupView
                      ? Align(
                          alignment: Alignment.bottomCenter,
                          child: Padding(
                            padding: const EdgeInsets.only(bottom: 10.0),
                            child: ElevatedButton(
                              onPressed: () {
                                setState(() {
                                  groupView = false;
                                });
                              },
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: AppColors.main,
                                  shape: const CircleBorder(
                                      side: BorderSide(
                                    color: Colors.black,
                                  )),
                                  fixedSize: Size(constraints.maxHeight,
                                      constraints.maxHeight)),
                              child: const Icon(
                                Icons.person_add,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        )
                      : Align(
                          alignment: Alignment.bottomCenter,
                          child: Padding(
                            padding: const EdgeInsets.only(bottom: 10.0),
                            child: ElevatedButton(
                              onPressed: () {
                                setState(() {
                                  groupView = true;
                                });
                              },
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: AppColors.main,
                                  shape: const CircleBorder(
                                      side: BorderSide(
                                    color: Colors.black,
                                  )),
                                  fixedSize: Size(constraints.maxHeight,
                                      constraints.maxHeight)),
                              child: const Icon(
                                Icons.people,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ),
                ],
              );
            }),
          ),
          body: groupView ? const GroupView() : const InvitationsView()),
    );
  }
}
