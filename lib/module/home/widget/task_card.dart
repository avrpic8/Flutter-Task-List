import 'package:flutter/material.dart';
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
  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);

    return InkWell(
      onTap: () {
        setState(() {
          widget.task.isCompleted = !widget.task.isCompleted;
        });
      },
      child: Container(
        height: 84,
        margin: const EdgeInsets.only(top: 8),
        padding: const EdgeInsets.only(left: 16, right: 16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: themeData.colorScheme.surface,
          border: Border.all(color: Colors.black.withOpacity(0.1), width: 1),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              //offset: const Offset(0, 2),
              blurRadius: 5,
            )
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
          ],
        ),
      ),
    );
  }
}
