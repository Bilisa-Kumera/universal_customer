import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:universal_customer/core/constants/widgets/custom_text.dart';
import 'package:universal_customer/core/utils/navigation_helper.dart';
import 'package:universal_customer/presentation/login/login_screen.dart';

import '../../core/constants/widgets/custom_button.dart';

class ForgetPasswordVerification extends StatefulWidget {
  const ForgetPasswordVerification({super.key});

  @override
  State<ForgetPasswordVerification> createState() =>
      _ForgetPasswordVerificationState();
}

class _ForgetPasswordVerificationState extends State<ForgetPasswordVerification> {
  String otpCode = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              InkWell(
                onTap: () => Navigator.pop(context),
                child: const Row(
                  children: [
                    Icon(Icons.arrow_back_ios, size: 16),
                    SizedBox(width: 4),
                    Text("Back", style: TextStyle(fontSize: 14)),
                  ],
                ),
              ),
              const SizedBox(height: 40),
              const CustomText(
                text: "Forgot Password",
                fontSize: 22,
                fontWeight: FontWeight.w700,
              ),
              const SizedBox(height: 8),
              const Text(
                "Code has been send to ***** ***70",
                style: TextStyle(color: Colors.grey),
              ),
              const SizedBox(height: 32),
              PinCodeTextField(
                appContext: context,
                length: 5,
                onChanged: (value) {
                  setState(() {
                    otpCode = value;
                  });
                },
                pinTheme: PinTheme(
                  shape: PinCodeFieldShape.box,
                  borderRadius: BorderRadius.circular(8),
                  fieldHeight: 50,
                  fieldWidth: 50,
                  activeFillColor: Colors.white,
                  inactiveColor: Colors.grey.shade300,
                  activeColor: Colors.orange,
                  selectedColor: Colors.orange,
                ),
              ),
              const SizedBox(height: 16),
              Center(
                child: Wrap(
                  children: [
                    const Text("Didn't receive code? "),
                    GestureDetector(
                      onTap: () {
                      },
                      child: const Text(
                        "Resend again",
                        style: TextStyle(
                          color: Color(0xFFF5A800),
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const Spacer(),
              SizedBox(
                width: double.infinity,
                height: 54,
                child: CustomButton(
                  onPressed: () {
                    NavigationHelper.push(context, LoginScreen());
                  },
                  text: "Verify",
                ),
              ),
              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }
}
