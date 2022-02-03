import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MyAppBar extends StatelessWidget {
  const MyAppBar({
    Key? key,
    required this.searchController,
    required this.notifier,
  }) : super(key: key);

  final TextEditingController searchController;
  final ValueNotifier notifier;

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    return Container(
      width: double.infinity,
      height: 110,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            themeData.colorScheme.primary,
            themeData.colorScheme.primaryVariant
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
                  style: themeData.textTheme.headline6,
                ),
                Icon(
                  CupertinoIcons.share,
                  color: themeData.colorScheme.onPrimary,
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
                color: themeData.colorScheme.onPrimary,
                borderRadius: BorderRadius.circular(19),
                boxShadow: [
                  BoxShadow(
                      color: Colors.black.withOpacity(0.1), blurRadius: 20)
                ],
              ),
              child: TextField(
                onChanged: (newValue) {
                  notifier.value = newValue;
                },
                controller: searchController,
                decoration: const InputDecoration(
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
