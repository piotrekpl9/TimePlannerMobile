import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:time_planner_mobile/presentation/common/app_colors.dart';
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
                    ...state.invitations.map(
                      (e) {
                        return Text(
                          "${e.groupName} - ${e.creator.email}",
                          style: TextStyle(color: AppColors.main),
                        );
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
