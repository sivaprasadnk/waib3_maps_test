import 'package:flutter/material.dart';
import 'package:machine_test/utils/constants.dart';

class WhereWouldGoContainer extends StatelessWidget {
  const WhereWouldGoContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 45,
      width: 300,
      decoration: BoxDecoration(
        color: kWhiteColor,
        boxShadow: const [
          BoxShadow(
            offset: Offset(0, 4),
            blurRadius: 15,
            spreadRadius: 0,
            color: kShadowColor,
          )
        ],
        borderRadius: BorderRadius.circular(10),
      ),
      child: const Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(width: 20),
          Icon(
            Icons.search,
            color: kBlackColor,
          ),
          SizedBox(width: 20),
          Text(
            'Where would you go?',
            style: TextStyle(
              color: kGrey2Color,
            ),
          )
        ],
      ),
    );
  }
}
