import 'package:flutter/material.dart';
import 'package:flutter_task_list/data/source/data_source.dart';

class Repository<T> with ChangeNotifier implements DataSource<T> {
  final DataSource<T> localDataSource;

  Repository({required this.localDataSource});

  @override
  Future<T> createOrUpdate(T data) async {
    final result = await localDataSource.createOrUpdate(data);
    notifyListeners();
    return result;
  }

  @override
  Future<void> delete(T data) async {
    await localDataSource.delete(data);
    notifyListeners();
  }

  @override
  Future<void> deleteAll() async {
    await localDataSource.deleteAll();
    notifyListeners();
  }

  @override
  Future<void> deleteById(id) async {
    await localDataSource.deleteById(id);
    notifyListeners();
  }

  @override
  Future<T> findById(id) {
    return localDataSource.findById(id);
  }

  @override
  Future<List<T>> getAll({String searchKeyword = ''}) {
    return localDataSource.getAll(searchKeyword: searchKeyword);
  }
}
