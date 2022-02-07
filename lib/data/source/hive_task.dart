import 'package:flutter_task_list/data/model/task.dart';
import 'package:flutter_task_list/data/source/data_source.dart';
import 'package:hive_flutter/hive_flutter.dart';

class HiveTask implements DataSource<Task> {
  final Box<Task> box;

  HiveTask({required this.box});

  @override
  Future<Task> createOrUpdate(Task data) async {
    if (data.isInBox) {
      data.save();
    } else {
      data.id = await box.add(data);
    }
    return data;
  }

  @override
  Future<void> delete(Task data) {
    return data.delete();
  }

  @override
  Future<void> deleteAll() {
    return box.clear();
  }

  @override
  Future<void> deleteById(id) {
    return box.delete(id);
  }

  @override
  Future<Task> findById(id) async {
    return box.values.firstWhere((element) => element.id == id);
  }

  @override
  Future<List<Task>> getAll({String searchKeyword = ''}) async {
    return box.values.toList();
  }
}
