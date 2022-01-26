import 'package:flutter/material.dart';
import 'package:flutter_task_list/core/constants.dart';
import 'package:flutter_task_list/data/model/task.dart';
import 'package:flutter_task_list/module/edit/edit_page.dart';
import 'package:hive_flutter/hive_flutter.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final box = Hive.box<Task>(taskBoxName);
    return Scaffold(
      appBar: AppBar(
        title: const Text('To Do List'),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => EditTaskPage()),
          );
        },
        label: const Text('Add New Task'),
      ),
      body: ValueListenableBuilder(
        valueListenable: box.listenable(),
        builder: (context, value, child) {
          return ListView.builder(
            itemCount: box.values.length,
            itemBuilder: (contex, index) {
              Task task = box.values.toList()[index];
              return Container(
                child: Text(task.name),
              );
            },
          );
        },
      ),
    );
  }
}
