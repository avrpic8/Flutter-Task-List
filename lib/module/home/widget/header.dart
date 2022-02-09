import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_task_list/core/values/colors.dart';
import 'package:flutter_task_list/data/model/task.dart';
import 'package:flutter_task_list/data/repo/repository.dart';
import 'package:provider/provider.dart';

class Header extends StatelessWidget {
  final ThemeData theme;
  const Header({Key? key, required this.theme}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final repository = Provider.of<Repository<Task>>(context, listen: false);
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Today',
                  style: theme.textTheme.headline6!
                      .apply(color: Colors.black, fontSizeFactor: 0.9),
                ),
                Container(
                  width: 70,
                  height: 3,
                  margin: const EdgeInsets.only(top: 3),
                  decoration: BoxDecoration(
                    color: theme.colorScheme.primary,
                    borderRadius: BorderRadius.circular(1.5),
                  ),
                )
              ],
            ),
            MaterialButton(
              onPressed: () {
                repository.deleteAll();
              },
              color: const Color(0xffeaeff5),
              textColor: secondryTextColor,
              elevation: 0,
              child: Row(
                children: const [
                  Text('Delete All'),
                  SizedBox(
                    width: 4,
                  ),
                  Icon(
                    CupertinoIcons.trash,
                    size: 18,
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 8,
        )
      ],
    );
  }
}
