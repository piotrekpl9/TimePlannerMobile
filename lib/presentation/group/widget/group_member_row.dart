import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:time_planner_mobile/domain/group/entity/member.dart';
import 'package:time_planner_mobile/presentation/common/app_colors.dart';
import 'package:time_planner_mobile/presentation/group/bloc/group_bloc.dart';

class GroupMemberRow extends StatelessWidget {
  final Member member;
  final bool showOptions;
  const GroupMemberRow(
      {super.key, required this.member, required this.showOptions});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          "${member.name} ${member.surname}",
          style:
              TextStyle(color: AppColors.main, overflow: TextOverflow.ellipsis),
        ),
        showOptions
            ? IconButton(
                onPressed: () {
                  context
                      .read<GroupBloc>()
                      .add(DeleteMemberButtonPressed(memberUUID: member.uuid));
                },
                icon: const Icon(
                  Icons.close,
                  color: Color.fromARGB(255, 255, 117, 107),
                ))
            : const SizedBox(),
      ],
    );
  }
}
