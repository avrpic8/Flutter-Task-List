import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_task_list/core/utile/app_theme.dart';
import 'package:flutter_task_list/core/values/colors.dart';
import 'package:flutter_task_list/core/utile/constants.dart';
import 'package:flutter_task_list/data/model/task.dart';
import 'package:flutter_task_list/module/home/home_page.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async {
  await Hive.initFlutter();
  Hive.registerAdapter(TaskAdapter());
  Hive.registerAdapter(PeriorityAdapter());
  await Hive.openBox<Task>(taskBoxName);
  SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(statusBarColor: primaryVariant));
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: AppTheme().getLightTheme(),
      home:  HomePage(),
    );
  }
}
