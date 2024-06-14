import 'package:calendar_view/calendar_view.dart';
import 'package:flutter/material.dart';
import 'package:time_planner_mobile/presentation/common/app_colors.dart';
import 'package:time_planner_mobile/presentation/schedule/filters/all_filter.dart';
import 'package:time_planner_mobile/presentation/schedule/filters/group_filter.dart';
import 'package:time_planner_mobile/presentation/schedule/filters/user_filter.dart';

class FilterMenu extends StatelessWidget {
  final EventController eventController;
  final void Function() onPressed;
  const FilterMenu({
    super.key,
    required this.onPressed,
    required this.eventController,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: FloatingActionButton(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
                side: BorderSide(color: AppColors.main, width: 2)),
            heroTag: UniqueKey(),
            backgroundColor: AppColors.secondary,
            onPressed: () {
              eventController.updateFilter(newFilter: groupFilter);
              onPressed();
            },
            child: Icon(
              Icons.group,
              color: AppColors.main,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: FloatingActionButton(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
                side: BorderSide(color: AppColors.main, width: 2)),
            heroTag: UniqueKey(),
            backgroundColor: AppColors.secondary,
            onPressed: () {
              eventController.updateFilter(newFilter: userFilter);
              onPressed();
            },
            child: Icon(
              Icons.person,
              color: AppColors.main,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: FloatingActionButton(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
                side: BorderSide(color: AppColors.main, width: 2)),
            heroTag: UniqueKey(),
            backgroundColor: AppColors.secondary,
            onPressed: () {
              eventController.updateFilter(newFilter: allFilter);
              onPressed();
            },
            child: Icon(
              Icons.filter_alt_off,
              color: AppColors.main,
            ),
          ),
        ),
      ],
    );
  }
}
