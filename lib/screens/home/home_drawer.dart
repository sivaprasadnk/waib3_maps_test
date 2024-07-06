import 'package:flutter/material.dart';
import 'package:machine_test/screens/auth/auth_screen.dart';
import 'package:machine_test/screens/home/drawer_item.dart';
import 'package:machine_test/utils/constants.dart';

class HomeDrawer extends StatelessWidget {
  const HomeDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: kDrawerColor,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(height: 50),
          InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: const Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(width: 16),
                Icon(
                  Icons.arrow_back_ios_new_rounded,
                  color: kWhiteColor,
                  size: 25,
                ),
                SizedBox(width: 16),
                Text(
                  'Back',
                  style: TextStyle(
                    color: kWhiteColor,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          const Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(width: 16),
              CircleAvatar(
                backgroundColor: kWhiteColor,
                child: Icon(
                  Icons.person,
                  color: kBlueColor,
                ),
              ),
              SizedBox(width: 16),
              Text(
                'Sithara Thomas',
                style: TextStyle(
                  color: kWhiteColor,
                ),
              )
            ],
          ),
          const SizedBox(height: 16),
          const Divider(),
          const SizedBox(height: 16),
          const DrawerItem(
            icon: Icons.speed_outlined,
            title: 'Ride History',
          ),
          const SizedBox(height: 16),
          const DrawerItem(
            icon: Icons.speed_outlined,
            title: 'Trips',
          ),
          const SizedBox(height: 16),
          const DrawerItem(
            icon: Icons.speed_outlined,
            title: 'Whiz+',
          ),
          const SizedBox(height: 16),
          const DrawerItem(
            icon: Icons.speed_outlined,
            title: 'Payments',
          ),
          const SizedBox(height: 16),
          const DrawerItem(
            icon: Icons.settings,
            title: 'Settings',
          ),
          const SizedBox(height: 16),
          const DrawerItem(
            icon: Icons.person,
            title: 'Profile',
          ),
          const SizedBox(height: 16),
          GestureDetector(
            onTap: () {
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (_) {
                return const AuthScreen();
              }));
              // Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (_){
              //   return AuthScreen();
              // }), ())
            },
            child: const DrawerItem(
              icon: Icons.logout,
              title: 'Sign out',
            ),
          ),
          const Spacer(),
          const Padding(
            padding: EdgeInsets.only(left: 16, bottom: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Help',
                  style: TextStyle(
                    color: kWhiteColor,
                    fontSize: 12,
                  ),
                ),
                SizedBox(height: 5),
                Text(
                  'FAQ',
                  style: TextStyle(
                    color: kWhiteColor,
                    fontSize: 12,
                  ),
                ),
                SizedBox(height: 5),
                Text(
                  'Privacy Policy',
                  style: TextStyle(
                    color: kWhiteColor,
                    fontSize: 12,
                  ),
                ),
                SizedBox(height: 5),
                Text(
                  'Terms & condition',
                  style: TextStyle(
                    color: kWhiteColor,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
