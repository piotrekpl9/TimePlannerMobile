import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:time_planner_mobile/presentation/common/app_colors.dart';
import 'package:time_planner_mobile/presentation/common/widgets/main_button.dart';
import 'package:time_planner_mobile/presentation/group/bloc/group_bloc.dart';

class InvitationsView extends StatefulWidget {
  const InvitationsView({super.key});

  @override
  State<InvitationsView> createState() => _InvitationsViewState();
}

class _InvitationsViewState extends State<InvitationsView> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GroupBloc, GroupState>(
      bloc: context.read<GroupBloc>(),
      builder: (context, state) {
        return Center(
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
                  state.invitations.isEmpty
                      ? Padding(
                          padding: const EdgeInsets.only(bottom: 20.0),
                          child: Text(
                            "There are no pending invitations",
                            style: TextStyle(color: AppColors.main),
                            textAlign: TextAlign.center,
                          ),
                        )
                      : const SizedBox(),
                  ...state.invitations.map(
                    (e) {
                      return Row(
                        children: [
                          Text(
                            "${e.groupName} - ${e.creator.email}",
                            style: TextStyle(
                                color: AppColors.main,
                                overflow: TextOverflow.ellipsis),
                          ),
                          const Spacer(),
                          IconButton(
                            icon: Icon(
                              Icons.done,
                              color: AppColors.main,
                            ),
                            onPressed: () {
                              context.read<GroupBloc>().add(
                                  UserAcceptedInvitationEvent(invitation: e));
                            },
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          IconButton(
                            icon: Icon(Icons.delete, color: AppColors.main),
                            onPressed: () {
                              context.read<GroupBloc>().add(
                                  UserRejectedInvitationEvent(invitation: e));
                            },
                          ),
                        ],
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
