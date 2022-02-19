import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_task_list/data/model/task.dart';
import 'package:flutter_task_list/data/repo/repository.dart';
import 'package:flutter_task_list/global_widgets/reusable_switch.dart';
import 'package:flutter_task_list/module/edit/cubit/edittask_cubit.dart';
import 'package:flutter_task_list/module/edit/edit_page.dart';
import 'package:flutter_task_list/module/home/bloc/tasklist_bloc.dart';
import 'package:flutter_task_list/module/home/widget/appbar.dart';
import 'package:flutter_task_list/module/home/widget/empty_state.dart';
import 'package:flutter_task_list/module/home/widget/task_lists.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  final searchBarController = TextEditingController();
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
        onClick: () {
          searchBarController.clear();
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => BlocProvider<EditTaskCubit>(
                create: (context) => EditTaskCubit(Task(), repository: context.read<Repository<Task>>()),
                child: const EditTaskPage(),
              ),
            ),
          );
        },
      ),
      body: BlocProvider<TaskListBloc>(
        create: (context) =>
            TaskListBloc(repository: context.read<Repository<Task>>()),
        child: SafeArea(
          child: Column(
            children: [
              MyAppBar(
                searchController: searchBarController,
              ),
              Expanded(
                child: Consumer<Repository<Task>>(
                  builder: (context, model, child) {
                    context.read<TaskListBloc>().add(TaskListStarted());
                    return BlocBuilder<TaskListBloc, TaskListState>(
                      builder: (context, state) {
                        if (state is TaskListSuccess) {
                          return TaskLists(
                              items: state.items, themData: themData);
                        } else if (state is TaskListEmpty) {
                          return const EmptyState();
                        } else if (state is TaskListLoading ||
                            state is TaskListInitial) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        } else if (state is TaskListError) {
                          return Center(
                            child: Text(state.errorMessage),
                          );
                        } else {
                          throw Exception('state is not valid');
                        }
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
