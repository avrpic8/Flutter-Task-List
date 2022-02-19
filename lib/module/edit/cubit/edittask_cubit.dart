import 'package:bloc/bloc.dart';
import 'package:flutter_task_list/data/model/task.dart';
import 'package:flutter_task_list/data/repo/repository.dart';
import 'package:meta/meta.dart';

part 'edittask_state.dart';

class EditTaskCubit extends Cubit<EditTaskState> {
  final Task _task;
  final Repository<Task> repository;
  EditTaskCubit(this._task, {required this.repository})
      : super(EditTaskInitial(_task));

  void onPriorityChanged(Periority periority) {
    _task.periority = periority;
    emit(EditTaskChangePriority(_task));
  }

  void onTextChanged(String text) {
    _task.name = text;
  }

  void onSaveChangesClicked() {
    repository.createOrUpdate(_task);
  }
}
