import 'package:flutter/material.dart';
import 'package:flutter_task_list/core/values/colors.dart';
import 'package:flutter_task_list/data/model/task.dart';
import 'package:flutter_task_list/module/home/widget/my_check_box.dart';

class TaskCard extends StatefulWidget {
  final Task task;
  const TaskCard({
    Key? key,
    required this.task,
  }) : super(key: key);

  @override
  State<TaskCard> createState() => _TaskCardState();
}

class _TaskCardState extends State<TaskCard> {
  final double taskCardRadius = 8;

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);

    final Color priorityColor;
    switch (widget.task.periority) {
      case Periority.low:
        priorityColor = lowPeriorityColor;
        break;

      case Periority.medium:
        priorityColor = mediumPeriorityColor;
        break;

      case Periority.high:
        priorityColor = highPeriorityColor;
        break;
    }

    return Padding(
      padding: const EdgeInsets.only(bottom: 5),
      child: Material(
        color: themeData.colorScheme.surface,
        child: InkWell(
          onTap: () {
            setState(() {
              widget.task.isCompleted = !widget.task.isCompleted;
            });
          },
          child: Container(
            height: 84,
            padding: const EdgeInsets.only(left: 16, right: 0),
            decoration: BoxDecoration(
              color: themeData.colorScheme.surface, //Colors.transparent,
              borderRadius: BorderRadius.circular(taskCardRadius),
              border:
                  Border.all(color: Colors.black.withOpacity(0.1), width: 1),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 7,
                ),
              ],
            ),
            child: Row(
              children: [
                MyCheckBox(value: widget.task.isCompleted),
                const SizedBox(
                  width: 16,
                ),
                Expanded(
                  child: Text(
                    widget.task.name,
                    style: TextStyle(
                      color: themeData.colorScheme.onSurface,
                      fontSize: 17,
                      overflow: TextOverflow.ellipsis,
                      decoration: widget.task.isCompleted
                          ? TextDecoration.lineThrough
                          : null,
                    ),
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                Container(
                  width: 5,
                  height: 84,
                  decoration: BoxDecoration(
                    color: priorityColor,
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(taskCardRadius),
                      bottomRight: Radius.circular(taskCardRadius),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
