import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_task_list/core/utile/constants.dart';
import 'package:flutter_task_list/core/values/colors.dart';
import 'package:flutter_task_list/data/model/task.dart';
import 'package:flutter_task_list/global/reusable_switch.dart';
import 'package:flutter_task_list/module/edit/widget/priority_check_box.dart';
import 'package:hive_flutter/hive_flutter.dart';

class EditTaskPage extends StatefulWidget {
  final Task task;

  const EditTaskPage({Key? key, required this.task}) : super(key: key);

  @override
  State<EditTaskPage> createState() => _EditTaskPageState();
}

class _EditTaskPageState extends State<EditTaskPage> {
  late TextEditingController _textController;

  @override
  void initState() {
    _textController = TextEditingController(text: widget.task.name);
    super.initState();
  }

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
          widget.task.name = _textController.text;
          if (widget.task.isInBox) {
            widget.task.save();
          } else {
            final box = Hive.box<Task>(taskBoxName);
            box.add(widget.task);
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
                    color: highPeriorityColor,
                    isSelected: widget.task.periority == Periority.high,
                    onClick: () {
                      setState(() {
                        widget.task.periority = Periority.high;
                      });
                    },
                  ),
                  flex: 1,
                ),
                const SizedBox(
                  width: 4,
                ),
                Flexible(
                  child: PriorityCheckBox(
                    label: 'Normal',
                    color: mediumPeriorityColor,
                    isSelected: widget.task.periority == Periority.medium,
                    onClick: () {
                      setState(() {
                        widget.task.periority = Periority.medium;
                      });
                    },
                  ),
                  flex: 1,
                ),
                const SizedBox(
                  width: 4,
                ),
                Flexible(
                  child: PriorityCheckBox(
                    label: 'Low',
                    color: lowPeriorityColor,
                    isSelected: widget.task.periority == Periority.low,
                    onClick: () {
                      setState(() {
                        widget.task.periority = Periority.low;
                      });
                    },
                  ),
                  flex: 1,
                )
              ],
            ),
            TextField(
              controller: _textController,
              decoration: InputDecoration(
                label: Text(
                  'Add a task for today...',
                  style:
                      themeData.textTheme.bodyText1!.apply(fontSizeFactor: 1.2),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }
}
