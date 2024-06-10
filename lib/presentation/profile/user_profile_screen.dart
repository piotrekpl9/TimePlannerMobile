import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:time_planner_mobile/presentation/common/app_colors.dart';
import 'package:time_planner_mobile/presentation/common/widgets/start_scaffold.dart';
import 'package:time_planner_mobile/presentation/schedule/bloc/calendar_bloc.dart';
import 'package:time_planner_mobile/presentation/schedule/schedule_screen.dart';

class UserProfileScreen extends StatefulWidget {
  static String path = "/profile";
  const UserProfileScreen({super.key});

  @override
  State<UserProfileScreen> createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage("assets/background2.png"), fit: BoxFit.cover),
        ),
        child: Scaffold(
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
                                color: Colors.white,
                              ),
                              onPressed: () {},
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
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 10.0),
                        child: ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.main,
                              shape: const CircleBorder(
                                  side: BorderSide(
                                color: Colors.black,
                              )),
                              fixedSize: Size(constraints.maxHeight,
                                  constraints.maxHeight)),
                          child: const Icon(
                            Icons.add,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                  ],
                );
              }),
            ),
            body: Center(
              child: Text("Hi! :) Enjoy your profile"),
            )));
  }
}
