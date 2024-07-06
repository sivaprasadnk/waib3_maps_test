import 'package:flutter/material.dart';
import 'package:machine_test/utils/constants.dart';

class TextfieldContainer extends StatelessWidget {
  const TextfieldContainer({super.key, required this.child});
  final Widget child;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        boxShadow: const [
          BoxShadow(
            offset: Offset(0, 4),
            blurRadius: 15,
            spreadRadius: 0,
            color: kShadowColor,
          )
        ],
        color: kWhiteColor,
        borderRadius: BorderRadius.circular(10),
      ),
      padding: const EdgeInsets.only(
        left: 16,
        right: 16,
        top: 0,
      ),
      child: child,
    );
  }
}
