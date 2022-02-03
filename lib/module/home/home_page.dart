import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_task_list/core/utile/constants.dart';
import 'package:flutter_task_list/data/model/task.dart';
import 'package:flutter_task_list/module/edit/edit_page.dart';
import 'package:flutter_task_list/module/home/widget/appbar.dart';
import 'package:flutter_task_list/module/home/widget/empty_state.dart';
import 'package:flutter_task_list/module/home/widget/header.dart';
import 'package:flutter_task_list/global/reusable_switch.dart';
import 'package:flutter_task_list/module/home/widget/task_card.dart';
import 'package:hive_flutter/hive_flutter.dart';

class HomePage extends StatelessWidget {
  final searchBarController = TextEditingController();
  final ValueNotifier<String> searchKeyWord = ValueNotifier('');
  HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final box = Hive.box<Task>(taskBoxName);
    final themData = Theme.of(context);
    return Scaffold(
      backgroundColor: themData.colorScheme.background,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: ReusableSwitch(
        textSwitch: 'Add New Task',
        icon: CupertinoIcons.add,
        onClick: () => Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => EditTaskPage(
              task: Task(),
            ),
          ),
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            MyAppBar(
              searchController: searchBarController,
              notifier: searchKeyWord,
            ),
            Expanded(
              child: ValueListenableBuilder(
                valueListenable: searchKeyWord,
                builder: (context, value, child) {
                  return ValueListenableBuilder(
                    valueListenable: box.listenable(),
                    builder: (context, value, child) {
                      var items = [];
                      if (searchBarController.text.isEmpty) {
                        items = box.values.toList();
                      } else {
                        items = box.values
                            .where((task) =>
                                task.name.contains(searchBarController.text))
                            .toList();
                      }
                      if (items.isNotEmpty) {
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
                      } else {
                        return const EmptyState();
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
