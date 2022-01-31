import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_task_list/core/values/colors.dart';

class PriorityCheckBox extends StatelessWidget {
  final String label;
  final Color color;
  final bool isSelected;
  final Function() onClick;

  const PriorityCheckBox(
      {Key? key,
      required this.label,
      required this.color,
      required this.isSelected, required this.onClick})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onClick(),
      child: Container(
        height: 40,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4),
          border: Border.all(
            width: 1,
            color: secondryTextColor,
          ),
        ),
        child: Stack(
          children: [
            Center(
              child: Text(label),
            ),
            Positioned(
              top: 0,
              right: 8,
              bottom: 0,
              child: Center(
                child: _CheckBoxShape(color: color, value: isSelected),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class _CheckBoxShape extends StatelessWidget {
  final Color color;
  final bool value;
  const _CheckBoxShape({Key? key, required this.color, required this.value})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    return Container(
      width: 16,
      height: 16,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: color,
      ),
      child: value
          ? Icon(
              CupertinoIcons.check_mark,
              size: 12,
              color: themeData.colorScheme.onPrimary,
            )
          : null,
    );
  }
}
