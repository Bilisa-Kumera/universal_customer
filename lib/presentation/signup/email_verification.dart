import 'package:flutter/material.dart';
import 'package:universal_customer/core/constants/widgets/custom_text.dart';
import 'package:universal_customer/core/constants/widgets/custom_textinput.dart';
import 'package:universal_customer/core/utils/navigation_helper.dart';
import 'package:universal_customer/presentation/signup/phone_verification.dart';

import '../../core/constants/widgets/custom_button.dart';

class EmailVerification extends StatefulWidget {
  const EmailVerification({super.key});

  @override
  State<EmailVerification> createState() =>
      _EmailVerificationState();
}

class _EmailVerificationState extends State<EmailVerification> {
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
                text: "Verification email or phone number",
                fontSize: 22,
                fontWeight: FontWeight.w700,
              ),
              
              const SizedBox(height: 32),
             CustomTextField(hintText: "Email or phone number"),
              const SizedBox(height: 16),
             
              const Spacer(),
              SizedBox(
                width: double.infinity,
                height: 54,
                child: CustomButton(
                  onPressed: () {
                    NavigationHelper.push(context, PhoneVerificationScreen());
                  },
                  text: "Send OTP",
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


