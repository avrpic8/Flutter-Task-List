import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MyAppBar extends StatelessWidget {
  const MyAppBar({
    Key? key,
    required this.themData,
  }) : super(key: key);

  final ThemeData themData;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 102,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            themData.colorScheme.primary,
            themData.colorScheme.primaryVariant
          ],
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(.6),
            blurRadius: 5.0,
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'To Do List',
                  style: themData.textTheme.headline6,
                ),
                Icon(
                  CupertinoIcons.share,
                  color: themData.colorScheme.onPrimary,
                )
              ],
            ),
            const SizedBox(
              height: 16,
            ),
            Container(
              width: double.infinity,
              height: 38,
              decoration: BoxDecoration(
                color: themData.colorScheme.onPrimary,
                borderRadius: BorderRadius.circular(19),
                boxShadow: [
                  BoxShadow(
                      color: Colors.black.withOpacity(0.1), blurRadius: 20)
                ],
              ),
              child: const TextField(
                decoration: InputDecoration(
                  prefixIcon: Icon(CupertinoIcons.search),
                  label: Text('Search tasks...'),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
