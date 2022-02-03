import 'package:flutter/material.dart';

class ReusableSwitch extends StatelessWidget {
  final String textSwitch;
  final IconData icon;
  final Function() onClick;
  const ReusableSwitch({
    Key? key,
    required this.onClick,
    required this.textSwitch,
    required this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    return Material(
      color: themeData.colorScheme.primary,
      borderRadius: BorderRadius.circular(5),
      child: InkWell(
        onTap: () => onClick(),
        splashColor: themeData.colorScheme.primary,
        child: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                textSwitch,
                style: TextStyle(color: themeData.colorScheme.surface),
              ),
              const SizedBox(
                width: 8,
              ),
              Container(
                width: 24,
                height: 24,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: themeData.colorScheme.onPrimary.withOpacity(.4)),
                child: Icon(
                  icon,
                  color: themeData.colorScheme.onSecondary,
                  size: 16,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
