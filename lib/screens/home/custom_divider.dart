import 'package:flutter/material.dart';
import 'package:machine_test/utils/constants.dart';

class CustomDivider extends StatelessWidget {
  const CustomDivider({super.key});

  @override
  Widget build(BuildContext context) {
    var color = const Color.fromRGBO(0, 0, 0, .5);
    return Column(
      children: [
        const SizedBox(height: 13),
        Container(
          height: 15,
          width: 15,
          decoration: BoxDecoration(
            border: Border.all(
              color: kBlueColor,
            ),
            borderRadius: BorderRadius.circular(30),
            // shape: BoxShape.circle,
          ),
          child: Center(
            child: Container(
              height: 5,
              width: 5,
              decoration: BoxDecoration(
                color: kBlueColor,
                borderRadius: BorderRadius.circular(30),
                // shape: BoxShape.circle,
              ),
            ),
          ),
        ),
        const SizedBox(height: 3),
        Container(
          width: 3,
          height: 7,
          color: color,
        ),
        const SizedBox(height: 3),
        Container(
          width: 3,
          height: 7,
          color: color,
        ),
        const SizedBox(height: 3),
        Container(
          width: 3,
          height: 7,
          color: color,
        ),
        const SizedBox(height: 3),
        Container(
          width: 3,
          height: 7,
          color: color,
        ),
        // const SizedBox(height: 3),
        // Container(
        //   width: 3,
        //   height: 7,
        //   color: color,
        // ),
        const SizedBox(height: 3),
        // Container(
        //   width: 3,
        //   height: 7,
        //   color: kGrey1Color,
        // ),
        const Icon(
          Icons.location_pin,
          color: kGreenColor,
        )
      ],
    );
  }
}
