import 'package:flutter/material.dart';
import 'package:time_planner_mobile/presentation/common/app_colors.dart';
import 'package:time_planner_mobile/presentation/common/widgets/main_floating_action_button.dart';

class ZoomMenu extends StatefulWidget {
  final double minuteHeight;
  final void Function(double) onValueChange;

  final void Function() onCancelPressed;

  const ZoomMenu({
    super.key,
    required this.onCancelPressed,
    required this.onValueChange,
    required this.minuteHeight,
  });

  @override
  State<ZoomMenu> createState() => _ZoomMenuState();
}

class _ZoomMenuState extends State<ZoomMenu> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
            padding: const EdgeInsets.all(8.0),
            child: MainFloatingActionButton(
              onPressed: () {
                setState(() {
                  if (widget.minuteHeight < 20) {
                    var result = widget.minuteHeight + 0.2;
                    widget.onValueChange(result);
                  }
                });
              },
              child: Icon(
                Icons.zoom_in,
                color: AppColors.main,
              ),
            )),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: MainFloatingActionButton(
            onPressed: () {
              setState(() {
                if (widget.minuteHeight > 0.8) {
                  var result = widget.minuteHeight - 0.2;
                  widget.onValueChange(result);
                }
              });
            },
            child: Icon(
              Icons.zoom_out,
              color: AppColors.main,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: MainFloatingActionButton(
            onPressed: () {
              setState(() {
                widget.onCancelPressed();
              });
            },
            child: Icon(
              Icons.search_off,
              color: AppColors.main,
            ),
          ),
        ),
      ],
    );
  }
}
