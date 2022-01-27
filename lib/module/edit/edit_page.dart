import 'package:flutter/material.dart';
import 'package:flutter_task_list/core/utile/constants.dart';
import 'package:flutter_task_list/data/model/task.dart';
import 'package:hive_flutter/hive_flutter.dart';

class EditTaskPage extends StatelessWidget {
  final _textController = TextEditingController();

  EditTaskPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Task'),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
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
        label: const Text('Save Changes'),
      ),
      body: Column(
        children: [
          TextField(
            controller: _textController,
            decoration:
                const InputDecoration(label: Text('Add a task for today...')),
          )
        ],
      ),
    );
  }
}
