import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class EmptyState extends StatelessWidget {
  const EmptyState({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SvgPicture.asset(
          'assets/empty_state.svg',
          width: 120,
        ),
        const SizedBox(
          height: 8,
        ),
        const Text('Your task list is empty!')
      ],
    );
  }
}
