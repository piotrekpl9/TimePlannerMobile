import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:time_planner_mobile/presentation/common/app_colors.dart';
import 'package:time_planner_mobile/presentation/common/widgets/main_button.dart';
import 'package:time_planner_mobile/presentation/group/bloc/group_bloc.dart';

class GroupView extends StatefulWidget {
  const GroupView({super.key});

  @override
  State<GroupView> createState() => _GroupViewState();
}

class _GroupViewState extends State<GroupView> {
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
          } else {
            _groupController.text = "";
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
                              borderSide:
                                  BorderSide(color: AppColors.main, width: 3)),
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide:
                                  BorderSide(color: AppColors.main, width: 3)),
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide:
                                  BorderSide(color: AppColors.main, width: 3)),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide:
                                  BorderSide(color: AppColors.main, width: 3))),
                      controller: _groupController,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Expanded(
                      child: Container(
                        alignment:
                            state.group == null ? Alignment.center : null,
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
                            crossAxisAlignment: CrossAxisAlignment.stretch,
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
                                    return Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 5.0),
                                      child: Text(
                                        "${e.name} ${e.surname}",
                                        style: TextStyle(
                                            color: AppColors.main,
                                            overflow: TextOverflow.ellipsis),
                                      ),
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
                    state.group != null
                        ? MainButton(
                            child: Text(
                              "Leave group",
                              style: TextStyle(color: AppColors.secondary),
                            ),
                            onPressed: () {
                              context
                                  .read<GroupBloc>()
                                  .add(LeaveGroupButtonPressedEvent());
                            },
                          )
                        : const SizedBox(),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
