import 'package:flutter/material.dart';
import 'package:machine_test/utils/constants.dart';

class LoginBtn extends StatelessWidget {
  const LoginBtn({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 55,
      decoration: BoxDecoration(
        color: kGreenColor,
        borderRadius: BorderRadius.circular(10),
      ),
      child: const Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(width: 30),
          Text(
            'Login',
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 14,
              color: kWhiteColor,
            ),
          ),
          Spacer(),
          Icon(
            Icons.arrow_right_alt_outlined,
            color: kWhiteColor,
          ),
          SizedBox(width: 30),
        ],
      ),
    );
  }
}
