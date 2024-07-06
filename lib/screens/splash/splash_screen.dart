import 'dart:async';

import 'package:flutter/material.dart';
import 'package:machine_test/screens/auth/auth_screen.dart';
import 'package:machine_test/screens/widgets/logo_text.dart';
import 'package:machine_test/utils/constants.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool _showCarImage = false;
  bool _moveTitle = false;
  bool _fadeOutText = false;

  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 3), () {
      setState(() {
        _showCarImage = true;
        _moveTitle = true;
        _fadeOutText = true;
      });

      Timer(const Duration(seconds: 1), () {
        Navigator.of(context).pushReplacement(
          PageRouteBuilder(
            pageBuilder: (context, animation1, animation2) =>
                const AuthScreen(),
            transitionDuration: Duration.zero,
            reverseTransitionDuration: Duration.zero,
          ),
        );
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBlackColor,
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: Stack(
          children: [
            AnimatedPositioned(
              duration: const Duration(seconds: 1),
              curve: Curves.easeInOut,
              top: _moveTitle
                  ? 100
                  : MediaQuery.of(context).size.height / 2 - 44,
              // left: MediaQuery.of(context).size.width * 0.25,
              // right: 0,
              child: SizedBox(
                width: MediaQuery.of(context).size.width,
                height: 150,
                child: Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const LogoText(),
                      const SizedBox(height: 30),
                      AnimatedOpacity(
                        duration: const Duration(milliseconds: 700),
                        opacity: _fadeOutText ? 0.0 : 1.0,
                        child: const Center(
                          child: Text(
                            'Get a new experience',
                            style: TextStyle(
                              color: kWhiteColor,
                              fontWeight: FontWeight.w500,
                              fontSize: 20,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            // AnimatedOpacity(
            //   duration: const Duration(milliseconds: 700),
            //   opacity: _fadeOutText ? 0.0 : 1.0,
            //   child: const Column(
            //     crossAxisAlignment: CrossAxisAlignment.center,
            //     mainAxisAlignment: MainAxisAlignment.center,
            //     children: [
            //       SizedBox(height: 50),
            //       Center(
            //         child: Text(
            //           'Get a new experience',
            //           style: TextStyle(
            //             color: kWhiteColor,
            //             fontWeight: FontWeight.w500,
            //             fontSize: 20,
            //           ),
            //         ),
            //       ),
            //     ],
            //   ),
            // ),
            AnimatedPositioned(
              duration: const Duration(seconds: 1),
              curve: Curves.easeInOut,
              bottom: _showCarImage ? -100 : -600,
              left: 0,
              right: 0,
              child: Image.asset(
                'assets/car.png', // Replace with your car image path
                width: 286,
              ),
            ),
          ],
        ),
      ),
    );
  }
}


// import 'package:flutter/material.dart';
// import 'package:machine_test/utils/constants.dart';

// class SplashScreen extends StatelessWidget {
//   const SplashScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return const Scaffold(
//       backgroundColor: kBlackColor,
//       body: Column(
//         crossAxisAlignment: CrossAxisAlignment.center,
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           Center(
//             child: Text.rich(
//               TextSpan(
//                 text: 'Car',
//                 style: TextStyle(
//                   color: kWhiteColor,
//                   fontWeight: FontWeight.w700,
//                   fontSize: 44,
//                 ),
//                 children: [
//                   TextSpan(
//                     text: 'Pool',
//                     style: TextStyle(
//                       color: kYellowColor,
//                       fontWeight: FontWeight.w700,
//                       fontSize: 44,
//                     ),
//                   )
//                 ],
//               ),
//             ),
//           ),
//           SizedBox(height: 20),
//           Text(
//             'Get a new experience',
//             style: TextStyle(
//               color: kWhiteColor,
//               fontWeight: FontWeight.w500,
//               fontSize: 20,
//             ),
//           )
//         ],
//       ),
//     );
//   }
// }
