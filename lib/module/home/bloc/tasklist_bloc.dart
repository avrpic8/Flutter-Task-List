import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_task_list/data/model/task.dart';
import 'package:flutter_task_list/data/repo/repository.dart';
import 'package:meta/meta.dart';

part 'tasklist_event.dart';
part 'tasklist_state.dart';

class TaskListBloc extends Bloc<TaskListEvent, TaskListState> {
  final Repository<Task> repository;

  TaskListBloc({required this.repository}) : super(TaskListInitial()) {
    on<TaskListEvent>(
      (event, emit) async {
        if (event is TaskListStarted || event is TaskListSearch) {
          final String searchTerm;

          // loading state
          emit(TaskListLoading());

          // search state
          if (event is TaskListSearch) {
            searchTerm = event.searchTerm;
          } else {
            searchTerm = '';
          }

          // success empty error states
          try {
            final items = await repository.getAll(searchKeyword: searchTerm);
            if (items.isNotEmpty) {
              emit(TaskListSuccess(items: items));
            } else {
              emit(TaskListEmpty());
            }
          } catch (e) {
            emit(TaskListError(e.toString()));
          }
        } else if (event is TaskListDeletAll) {
          await repository.deleteAll();
          emit(TaskListEmpty());
        }
      },
    );
  }
}
