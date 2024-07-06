import 'package:flutter/material.dart';
import 'package:machine_test/utils/constants.dart';

class LogoText extends StatelessWidget {
  const LogoText({super.key});

  @override
  Widget build(BuildContext context) {
    return const Text.rich(
      TextSpan(
        text: 'Car',
        style: TextStyle(
          color: kWhiteColor,
          fontWeight: FontWeight.w700,
          fontSize: 44,
        ),
        children: [
          TextSpan(
            text: 'Pool',
            style: TextStyle(
              color: kYellowColor,
              fontWeight: FontWeight.w700,
              fontSize: 44,
            ),
          ),
        ],
      ),
    );
  }
}
