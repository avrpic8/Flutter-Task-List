import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_task_list/core/values/colors.dart';
import 'package:flutter_task_list/data/model/task.dart';
import 'package:flutter_task_list/data/repo/repository.dart';
import 'package:flutter_task_list/global_widgets/reusable_switch.dart';
import 'package:flutter_task_list/module/edit/cubit/edittask_cubit.dart';
import 'package:flutter_task_list/module/edit/widget/priority_check_box.dart';
import 'package:provider/provider.dart';

class EditTaskPage extends StatefulWidget {
  const EditTaskPage({Key? key}) : super(key: key);

  @override
  State<EditTaskPage> createState() => _EditTaskPageState();
}

class _EditTaskPageState extends State<EditTaskPage> {
  late TextEditingController _textController;

  @override
  void initState() {
    _textController = TextEditingController(
        text: context.read<EditTaskCubit>().state.task.name);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    final repository = Provider.of<Repository<Task>>(context, listen: false);
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
          context.read<EditTaskCubit>().onSaveChangesClicked();
          Navigator.pop(context);
        },
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            BlocBuilder<EditTaskCubit, EditTaskState>(
              builder: (context, state) {
                final priority = state.task.periority;
                return Flex(
                  direction: Axis.horizontal,
                  children: [
                    Flexible(
                      child: PriorityCheckBox(
                        label: 'High',
                        color: highPeriorityColor,
                        isSelected: priority == Periority.high,
                        onClick: () {
                          context
                              .read<EditTaskCubit>()
                              .onPriorityChanged(Periority.high);
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
                        isSelected: priority == Periority.medium,
                        onClick: () {
                          context
                              .read<EditTaskCubit>()
                              .onPriorityChanged(Periority.medium);
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
                        isSelected: priority == Periority.low,
                        onClick: () {
                          context
                              .read<EditTaskCubit>()
                              .onPriorityChanged(Periority.low);
                        },
                      ),
                      flex: 1,
                    )
                  ],
                );
              },
            ),
            TextField(
              controller: _textController,
              onChanged: (text)=> context.read<EditTaskCubit>().onTextChanged(text),
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
