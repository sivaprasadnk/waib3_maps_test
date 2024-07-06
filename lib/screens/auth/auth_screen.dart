import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:machine_test/screens/auth/login_btn.dart';
import 'package:machine_test/screens/home/home_screen.dart';
import 'package:machine_test/screens/widgets/logo_text.dart';
import 'package:machine_test/utils/constants.dart';
import 'package:twilio_flutter/twilio_flutter.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final TwilioFlutter twilioFlutter = TwilioFlutter(
    accountSid: dotenv.env['ACCOUNT_SID']!,
    authToken: dotenv.env['AUTH_TOKEN']!,
    twilioNumber: '+918086028340',
  );

  bool _showSignInFields = false;
  bool _showSignUpFields = false;
  TwilioResponse? response;

  final TextEditingController _numberController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();

  checkAndNavigate() async {
    var number = _numberController.text;
    if (!number.startsWith('+')) {
      number = "+$number";
    } else if (!number.startsWith('+91')) {
      number = "+91$number";
    }

    if (number == "+91$kSignInNumber") {
      setState(() {
        _showSignInFields = true;
      });
      navigateToHome();
    } else {
      if (_emailController.text.isEmpty || _nameController.text.isEmpty) {
        setState(() {
          _showSignUpFields = true;
        });
      } else {
        sendOtp();
        await showDialog(
          context: context,
          builder: (_) {
            return AlertDialog(
              title: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: const Icon(
                      Icons.close,
                    ),
                  )
                ],
              ),
              content: SizedBox(
                height: 220,
                width: 100,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text(
                      'Verify your Mobile',
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 20),
                    SizedBox(
                      width: 275,
                      child: Text(
                        'Verification code has been sent to your registered mobile ${_numberController.text}',
                        style: const TextStyle(
                          // fontWeight: FontWeight.w700,
                          fontSize: 14,
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    TextField(
                      onSubmitted: (value) async {
                        TwilioResponse response =
                            await twilioFlutter.verifyCode(
                          verificationServiceId:
                              dotenv.env['SERVICE_ID']!,
                          recipient: _numberController.text,
                          code: value,
                        );

                        if (response.responseState == ResponseState.SUCCESS) {
                          navigateToHome();
                        } else {
                          if (mounted) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Invalid OTP'),
                              ),
                            );
                          }
                        }
                      },
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        hintText: 'Enter OTP *',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(
                            10,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        GestureDetector(
                          onTap: () {
                            sendOtp();
                          },
                          child: const Text(
                            'Resend Code',
                            style: TextStyle(
                              color: kBlueColor,
                              fontWeight: FontWeight.w500,
                              fontSize: 14,
                            ),
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
            );
          },
        );
      }
    }
  }

  sendOtp() async {
    response = await twilioFlutter.sendVerificationCode(
      verificationServiceId: dotenv.env['SERVICE_ID']!,
      recipient: _numberController.text,
      verificationChannel: VerificationChannel.SMS,
    );
  }

  navigateToHome() {
    Future.delayed((const Duration(seconds: 1))).then((_) {
      Navigator.pop(context);
      Navigator.push(context, MaterialPageRoute(builder: (_) {
        return const HomeScreen();
      }));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: kBlackColor,
      body: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(height: 100),
          const LogoText(),
          SizedBox(
            width: double.infinity,
            height: MediaQuery.of(context).size.height - 165,
            child: Stack(
              children: [
                Positioned(
                  bottom: -103,
                  left: 0,
                  right: 0,
                  child: Image.asset(
                    'assets/car.png', // Replace with your car image path
                    width: 286,
                  ),
                ),
                Positioned(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const SizedBox(height: 40),
                        TextFormField(
                          controller: _numberController,
                          keyboardType: TextInputType.phone,
                          style: const TextStyle(
                            color: kWhiteColor,
                          ),
                          decoration: InputDecoration(
                            prefixIcon: const Icon(
                              Icons.call_outlined,
                              color: kGrey1Color,
                            ),
                            suffixIcon: _showSignUpFields
                                ? const Icon(
                                    Icons.refresh_outlined,
                                    color: kRedColor,
                                  )
                                : _showSignInFields
                                    ? const Icon(
                                        Icons.check_circle_outline,
                                        color: kGreenColor,
                                      )
                                    : null,
                            hintText: 'Mobile Number *',
                            hintStyle: const TextStyle(
                              color: kGrey1Color,
                            ),
                            border: OutlineInputBorder(
                              borderSide: const BorderSide(
                                color: kGrey1Color,
                              ),
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        ),
                        if (_showSignUpFields)
                          Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const SizedBox(height: 10),
                              TextFormField(
                                style: const TextStyle(
                                  color: kWhiteColor,
                                ),
                                keyboardType: TextInputType.name,
                                controller: _nameController,
                                decoration: InputDecoration(
                                  hintText: 'Full Name',
                                  hintStyle: const TextStyle(
                                    color: kGrey1Color,
                                  ),
                                  border: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                      color: kGrey1Color,
                                    ),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 10),
                              TextFormField(
                                keyboardType: TextInputType.emailAddress,
                                controller: _emailController,
                                style: const TextStyle(
                                  color: kWhiteColor,
                                ),
                                decoration: InputDecoration(
                                  hintText: 'Email',
                                  hintStyle: const TextStyle(
                                    color: kGrey1Color,
                                  ),
                                  border: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                      color: kGrey1Color,
                                    ),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 30),
                              const Text(
                                'By clicking continue, you agree to our',
                                style: TextStyle(
                                  color: kWhiteColor,
                                  fontSize: 14,
                                ),
                              ),
                              // const SizedBox(height: 10),
                              const Text(
                                'Terms of Service and Privacy Policy',
                                style: TextStyle(
                                  color: kWhiteColor,
                                  fontWeight: FontWeight.w700,
                                  fontSize: 14,
                                ),
                              ),
                            ],
                          )
                        else if (_showSignInFields)
                          const Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              SizedBox(height: 55),
                              Text(
                                'Welcome Back to CarPool',
                                style: TextStyle(
                                  color: kGrey3Color,
                                  fontSize: 14,
                                ),
                              ),
                              SizedBox(height: 95),
                            ],
                          ),
                        const SizedBox(height: 20),
                        GestureDetector(
                          onTap: () {
                            FocusScope.of(context).unfocus();
                            checkAndNavigate();
                          },
                          child: const LoginBtn(),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
