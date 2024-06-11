import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:time_planner_mobile/presentation/common/app_colors.dart';
import 'package:time_planner_mobile/presentation/common/widgets/generic_form_field.dart';
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
                    GenericFormField(
                      controller: _groupController,
                      enabled: false,
                    ),
                    if (state.group != null)
                      ...state.group!.members.map(
                        (e) {
                          return Text("${e.name} ${e.surname}");
                        },
                      ),
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
