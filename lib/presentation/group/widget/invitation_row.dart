import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:time_planner_mobile/domain/group/entity/invitation.dart';
import 'package:time_planner_mobile/presentation/common/app_colors.dart';
import 'package:time_planner_mobile/presentation/group/bloc/group_bloc.dart';

class InvitationRow extends StatelessWidget {
  final Invitation invitation;
  const InvitationRow({super.key, required this.invitation});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          "${invitation.groupName} - ${invitation.creator.email}",
          style:
              TextStyle(color: AppColors.main, overflow: TextOverflow.ellipsis),
        ),
        const Spacer(),
        IconButton(
          icon: Icon(
            Icons.done,
            color: AppColors.main,
          ),
          onPressed: () {
            context
                .read<GroupBloc>()
                .add(UserAcceptedInvitationEvent(invitation: invitation));
          },
        ),
        const SizedBox(
          width: 10,
        ),
        IconButton(
          icon: Icon(Icons.delete, color: AppColors.main),
          onPressed: () {
            context
                .read<GroupBloc>()
                .add(UserRejectedInvitationEvent(invitation: invitation));
          },
        ),
      ],
    );
  }
}
