import 'package:flutter/material.dart';
import 'package:flutter_task_list/data/model/task.dart';
import 'package:flutter_task_list/module/home/widget/task_card.dart';

import 'header.dart';

class TaskLists extends StatelessWidget {
  final List<Task> items;
  const TaskLists({Key? key, required this.items, required this.themData})
      : super(key: key);

  final ThemeData themData;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 100),
      itemCount: items.length + 1,
      itemBuilder: (contex, index) {
        if (index == 0) {
          return Header(
            theme: themData,
          );
        } else {
          Task task = items[index - 1];
          return TaskCard(task: task);
        }
      },
    );
  }
}