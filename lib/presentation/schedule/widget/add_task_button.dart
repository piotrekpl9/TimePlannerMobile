import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:time_planner_mobile/presentation/common/app_colors.dart';
import 'package:time_planner_mobile/presentation/schedule/create_task_screen.dart';

class AddTaskButton extends StatelessWidget {
  const AddTaskButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: SizedBox(
        height: 80,
        child: ElevatedButton(
          onPressed: () {
            context.push(CreateTaskScreen.path);
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.main,
            shape: const CircleBorder(
                side: BorderSide(
              color: Colors.black,
            )),
          ),
          child: const Icon(
            Icons.add,
            color: Colors.black,
          ),
        ),
      ),
    );
  }
}
