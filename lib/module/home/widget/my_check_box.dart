import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_task_list/core/values/colors.dart';

class MyCheckBox extends StatelessWidget {
  final bool value;
  final GestureTapCallback onClick;

  const MyCheckBox({Key? key, required this.value, required this.onClick}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    return InkWell(
      onTap: onClick,
      child: Container(
        width: 24,
        height: 24,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            border:
                !value ? Border.all(color: secondryTextColor, width: 2) : null,
            color: value ? primaryColor : null),
        child: value
            ? Icon(
                CupertinoIcons.check_mark,
                color: themeData.colorScheme.onPrimary,
                size: 18,
              )
            : null,
      ),
    );
  }
}
