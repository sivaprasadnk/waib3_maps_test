import 'package:flutter/material.dart';
import 'package:machine_test/utils/constants.dart';

class BottomSheetContainer extends StatelessWidget {
  const BottomSheetContainer(
      {super.key, required this.isExpanded, required this.child});
  final Widget child;
  final bool isExpanded;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: isExpanded ? 200 : 100,
      padding: EdgeInsets.only(
        top: 25,
        bottom: isExpanded ? 0 : 25,
        right: 25,
        left: 25,
      ),
      decoration: const BoxDecoration(
        color: kWhiteColor,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(25),
          topRight: Radius.circular(25),
        ),
      ),
      child: child,
    );
  }
}
