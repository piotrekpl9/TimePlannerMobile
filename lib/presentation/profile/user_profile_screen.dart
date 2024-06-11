import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:time_planner_mobile/presentation/common/app_colors.dart';
import 'package:time_planner_mobile/presentation/common/widgets/generic_form_field.dart';
import 'package:time_planner_mobile/presentation/common/widgets/main_button.dart';
import 'package:time_planner_mobile/presentation/profile/bloc/user_profile_bloc.dart';
import 'package:time_planner_mobile/presentation/profile/widgets/change_password_dialog.dart';
import 'package:time_planner_mobile/presentation/schedule/schedule_screen.dart';

class UserProfileScreen extends StatefulWidget {
  static String path = "/profile";
  const UserProfileScreen({super.key});

  @override
  State<UserProfileScreen> createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreen> {
  bool groupView = false;
  final emailController = TextEditingController();
  final nameController = TextEditingController();
  final surnameController = TextEditingController();

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
                    !groupView
                        ? Align(
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
                          )
                        : Align(
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
                                  Icons.person,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ),
                  ],
                );
              }),
            ),
            body: BlocBuilder<UserProfileBloc, UserProfileState>(
              bloc: context.read<UserProfileBloc>(),
              builder: (context, state) {
                if (state.status == UserProfileStatus.idle) {
                  final user = state.user;
                  if (user != null) {
                    nameController.text = user.name;
                    surnameController.text = user.surname;
                    emailController.text = user.email;
                  }
                }
                return Center(
                  child: Padding(
                    padding: const EdgeInsets.all(30.0),
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: AppColors.main,
                          width: 3,
                        ),
                        borderRadius: BorderRadius.circular(15),
                        color: AppColors.secondary,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Icon(
                              Icons.person_outline,
                              size: 64,
                              color: AppColors.main,
                            ),
                            const SizedBox(
                              height: 30,
                            ),
                            GenericFormField(
                              controller: nameController,
                              enabled: false,
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            GenericFormField(
                                controller: surnameController, enabled: false),
                            const SizedBox(
                              height: 20,
                            ),
                            GenericFormField(
                                controller: emailController, enabled: false),
                            const SizedBox(
                              height: 30,
                            ),
                            MainButton(
                              child: Text(
                                "Change password",
                                style: TextStyle(color: AppColors.secondary),
                              ),
                              onPressed: () {
                                showAdaptiveDialog(
                                  context: context,
                                  builder: (ctx) => BlocProvider.value(
                                    value: context.read<UserProfileBloc>(),
                                    child: const ChangePasswordDialog(),
                                  ),
                                );
                              },
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            )));
  }
}
