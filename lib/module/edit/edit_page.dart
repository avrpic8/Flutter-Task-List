import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_task_list/core/utile/constants.dart';
import 'package:flutter_task_list/core/values/colors.dart';
import 'package:flutter_task_list/data/model/task.dart';
import 'package:flutter_task_list/global/reusable_switch.dart';
import 'package:flutter_task_list/module/edit/widget/priority_check_box.dart';
import 'package:hive_flutter/hive_flutter.dart';

class EditTaskPage extends StatelessWidget {
  final _textController = TextEditingController();
  final Task newTask;

  EditTaskPage({Key? key, required this.newTask}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    return Scaffold(
      backgroundColor: themeData.colorScheme.background,
      appBar: AppBar(
        title: const Text('Edit Task'),
        backgroundColor: themeData.colorScheme.surface,
        foregroundColor: themeData.colorScheme.onSurface,
        elevation: 0,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: ReusableSwitch(
        icon: CupertinoIcons.check_mark,
        textSwitch: 'Save Changes',
        onClick: () {
          final task = Task()
            ..name = _textController.text
            ..periority = Periority.low;

          if (task.isInBox) {
            task.save();
          } else {
            final box = Hive.box<Task>(taskBoxName);
            box.add(task);
          }
          Navigator.pop(context);
        },
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Flex(
              direction: Axis.horizontal,
              children: [
                Flexible(
                  child: PriorityCheckBox(
                    label: 'High',
                    color: primaryColor,
                    isSelected: newTask.periority == Periority.high,
                  ),
                  flex: 1,
                ),
                const SizedBox(
                  width: 4,
                ),
                Flexible(
                  child: PriorityCheckBox(
                    label: 'Normal',
                    color: const Color(0xfff09819),
                    isSelected: newTask.periority == Periority.medium,
                  ),
                  flex: 1,
                ),
                const SizedBox(
                  width: 4,
                ),
                Flexible(
                  child: PriorityCheckBox(
                    label: 'Low',
                    color: const Color(0xff3be1f1),
                    isSelected: newTask.periority == Periority.low,
                  ),
                  flex: 1,
                )
              ],
            ),
            TextField(
              controller: _textController,
              decoration:
                  const InputDecoration(label: Text('Add a task for today...')),
            )
          ],
        ),
      ),
    );
  }
}
