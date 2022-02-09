import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_task_list/data/model/task.dart';
import 'package:flutter_task_list/data/repo/repository.dart';
import 'package:flutter_task_list/global_widgets/reusable_switch.dart';
import 'package:flutter_task_list/module/edit/edit_page.dart';
import 'package:flutter_task_list/module/home/widget/appbar.dart';
import 'package:flutter_task_list/module/home/widget/empty_state.dart';
import 'package:flutter_task_list/module/home/widget/task_lists.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  final searchBarController = TextEditingController();
  final ValueNotifier<String> searchKeyWord = ValueNotifier('');
  HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
                  return Consumer<Repository<Task>>(
                    builder: (context, repository, child) {
                      return FutureBuilder<List<Task>>(
                        future: repository.getAll(
                            searchKeyword: searchBarController.text),
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            if (snapshot.data!.isNotEmpty) {
                              return TaskLists(
                                items: snapshot.data!,
                                themData: themData,
                              );
                            } else {
                              return const EmptyState();
                            }
                          } else {
                            return const CircularProgressIndicator();
                          }
                        },
                      );
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
