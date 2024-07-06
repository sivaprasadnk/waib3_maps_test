import 'package:flutter/material.dart';
import 'package:machine_test/utils/constants.dart';

class BottomNavBar extends StatelessWidget {
  const BottomNavBar({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 62,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          const Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.directions_car_filled,
                color: kGrey1Color,
              ),
              Text('Rides'),
            ],
          ),
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.asset(
                'assets/tag.png',
                height: 20,
              ),
              const Text('Trips'),
            ],
          ),
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.asset(
                'assets/person.png',
                height: 20,
              ),
              const Text('Whiz+'),
            ],
          ),
        ],
      ),
    );
  }
}
