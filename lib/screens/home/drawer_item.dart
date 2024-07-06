import 'package:flutter/material.dart';
import 'package:machine_test/utils/constants.dart';

class DrawerItem extends StatelessWidget {
  const DrawerItem({
    super.key,
    required this.icon,
    required this.title,
  });
  final IconData icon;
  final String title;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const SizedBox(width: 16),
        Icon(
          icon,
          color: kWhiteColor,
        ),
        const SizedBox(width: 5),
        Text(
          title,
          style: const TextStyle(
            color: kWhiteColor,
          ),
        )
      ],
    );
  }
}
