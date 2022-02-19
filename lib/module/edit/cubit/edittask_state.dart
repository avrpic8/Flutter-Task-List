part of 'edittask_cubit.dart';

@immutable
abstract class EditTaskState {
  final Task task;

  const EditTaskState({required this.task});
}

class EditTaskInitial extends EditTaskState {
  const EditTaskInitial(Task task) : super(task: task);
}

class EditTaskChangePriority extends EditTaskState {
  const EditTaskChangePriority(Task task) : super(task: task);
}
