import 'package:flutter/material.dart';
import 'package:flutter_task_list/core/utile/constants.dart';
import 'package:flutter_task_list/data/model/task.dart';
import 'package:flutter_task_list/module/edit/edit_page.dart';
import 'package:flutter_task_list/module/home/widget/appbar.dart';
import 'package:flutter_task_list/module/home/widget/header.dart';
import 'package:hive_flutter/hive_flutter.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final box = Hive.box<Task>(taskBoxName);
    final themData = Theme.of(context);
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => EditTaskPage()),
          );
        },
        label: const Text('Add New Task'),
      ),
      body: SafeArea(
        child: Column(
          children: [
            MyAppBar(themData: themData),
            Expanded(
              child: ValueListenableBuilder(
                valueListenable: box.listenable(),
                builder: (context, value, child) {
                  return ListView.builder(
                    padding: const EdgeInsets.fromLTRB(16, 16, 16, 100),
                    itemCount: box.values.length + 1,
                    itemBuilder: (contex, index) {
                      if (index == 0) {
                        return Header(theme: themData,);
                      } else {
                        Task task = box.values.toList()[index - 1];
                        return Container(
                          child: Text(task.name),
                        );
                      }
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
