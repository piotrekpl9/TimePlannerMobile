import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:time_planner_mobile/domain/group/member_role.dart';
import 'package:time_planner_mobile/presentation/common/app_colors.dart';
import 'package:time_planner_mobile/presentation/common/widgets/main_button.dart';
import 'package:time_planner_mobile/presentation/group/bloc/group_bloc.dart';
import 'package:time_planner_mobile/presentation/group/invitations_screen.dart';
import 'package:time_planner_mobile/presentation/group/widget/create_group_dialog.dart';
import 'package:time_planner_mobile/presentation/group/widget/invite_user_to_group_dialog.dart';

class GroupView extends StatefulWidget {
  const GroupView({super.key});

  @override
  State<GroupView> createState() => _GroupViewState();
}

class _GroupViewState extends State<GroupView> {
  bool groupAdmin = false;
  final TextEditingController _groupController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GroupBloc, GroupState>(
      bloc: context.read<GroupBloc>(),
      builder: (context, state) {
        if (state.status == GroupBlocStatus.idle) {
          final group = state.group;
          if (group != null) {
            _groupController.text = group.name;
            if (state.user != null) {
              var userMember = group.members.firstWhere(
                (element) {
                  return element.email == state.user!.email;
                },
              );
              groupAdmin = userMember.role == MemberRole.admin;
            }
          } else {
            _groupController.text = "";
          }
        }
        return Stack(
          children: [
            Center(
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
                  child: Center(
                    child: state.group != null
                        ? Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Icon(
                                Icons.people_outline,
                                size: 64,
                                color: AppColors.main,
                              ),
                              const SizedBox(
                                height: 30,
                              ),
                              TextFormField(
                                cursorColor: AppColors.main,
                                style: TextStyle(
                                    color: AppColors.main,
                                    fontSize: 20,
                                    decoration: null,
                                    decorationStyle: null,
                                    textBaseline: null),
                                decoration: InputDecoration(
                                    enabled: false,
                                    hintText: "Name",
                                    hintStyle: TextStyle(color: AppColors.main),
                                    contentPadding: const EdgeInsets.all(15),
                                    disabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10),
                                        borderSide: BorderSide(
                                            color: AppColors.main, width: 3)),
                                    enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10),
                                        borderSide: BorderSide(
                                            color: AppColors.main, width: 3)),
                                    focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10),
                                        borderSide: BorderSide(
                                            color: AppColors.main, width: 3)),
                                    border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10),
                                        borderSide: BorderSide(
                                            color: AppColors.main, width: 3))),
                                controller: _groupController,
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              Expanded(
                                child: Container(
                                  alignment: state.group == null
                                      ? Alignment.center
                                      : null,
                                  padding: const EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      color: AppColors.main,
                                      width: 3,
                                    ),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: SingleChildScrollView(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.stretch,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: state.group != null
                                              ? Text(
                                                  "Members",
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                      color: AppColors.main,
                                                      fontSize: 18),
                                                )
                                              : const SizedBox(),
                                        ),
                                        if (state.group == null)
                                          Center(
                                            child: Text(
                                              "Nothing to see here",
                                              style: TextStyle(
                                                color: AppColors.main,
                                              ),
                                              textAlign: TextAlign.center,
                                            ),
                                          ),
                                        if (state.group != null)
                                          ...state.group!.members.map(
                                            (e) {
                                              return Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Text(
                                                    "${e.name} ${e.surname}",
                                                    style: TextStyle(
                                                        color: AppColors.main,
                                                        overflow: TextOverflow
                                                            .ellipsis),
                                                  ),
                                                  groupAdmin &&
                                                          e.email !=
                                                              state.user?.email
                                                      ? IconButton(
                                                          onPressed: () {
                                                            context
                                                                .read<
                                                                    GroupBloc>()
                                                                .add(DeleteMemberButtonPressed(
                                                                    memberUUID:
                                                                        e.uuid));
                                                          },
                                                          icon: const Icon(
                                                            Icons.close,
                                                            color:
                                                                Color.fromARGB(
                                                                    255,
                                                                    255,
                                                                    117,
                                                                    107),
                                                          ))
                                                      : const SizedBox(),
                                                ],
                                              );
                                            },
                                          ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  state.group != null
                                      ? Expanded(
                                          child: MainButton(
                                            child: Text(
                                              "Invite",
                                              style: TextStyle(
                                                  color: AppColors.secondary),
                                            ),
                                            onPressed: () {
                                              showAdaptiveDialog(
                                                context: context,
                                                builder: (ctx) {
                                                  return BlocProvider.value(
                                                      value: context
                                                          .read<GroupBloc>(),
                                                      child:
                                                          const InviteUserDialog());
                                                },
                                              );
                                            },
                                          ),
                                        )
                                      : const SizedBox(),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  state.group != null
                                      ? Expanded(
                                          child: MainButton(
                                            child: Text(
                                              "Leave",
                                              style: TextStyle(
                                                  color: AppColors.secondary),
                                            ),
                                            onPressed: () {
                                              context.read<GroupBloc>().add(
                                                  LeaveGroupButtonPressedEvent());
                                            },
                                          ),
                                        )
                                      : const SizedBox(),
                                ],
                              ),
                            ],
                          )
                        : Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Text(
                                "You have to be a group member to see content here",
                                style: TextStyle(color: AppColors.main),
                                textAlign: TextAlign.center,
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              MainButton(
                                onPressed: () {
                                  showDialog(
                                    context: context,
                                    builder: (ctx) {
                                      return BlocProvider.value(
                                        value: context.read<GroupBloc>(),
                                        child: CreateGroupDialog(),
                                      );
                                    },
                                  );
                                },
                                child: Text(
                                  "Create group",
                                  style: TextStyle(color: AppColors.secondary),
                                ),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              MainButton(
                                onPressed: () {
                                  context.push(InvitationsScreen.path);
                                },
                                child: Text(
                                  "View invitations",
                                  style: TextStyle(color: AppColors.secondary),
                                ),
                              ),
                            ],
                          ),
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
