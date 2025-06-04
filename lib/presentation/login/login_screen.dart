import 'package:flutter/material.dart';
import 'package:universal_customer/core/constants/colors.dart';
import 'package:universal_customer/core/constants/spacings.dart';
import 'package:universal_customer/core/constants/widgets/custom_text.dart';
import 'package:universal_customer/core/utils/navigation_helper.dart';
import 'package:universal_customer/presentation/home/home_screen.dart';
import 'package:universal_customer/presentation/login/forget_password.dart';

import '../../core/constants/widgets/custom_button.dart';
import '../../core/constants/widgets/custom_textinput.dart';

import '../signup/create_account.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  String completePhoneNumber = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 16),
                InkWell(
                  onTap: () => Navigator.pop(context),
                  child: const Row(
                    children: [
                      Icon(Icons.arrow_back_ios),
                      SizedBox(width: 8),
                      Text("Back", style: TextStyle(fontSize: 16)),
                    ],
                  ),
                ),
                const SizedBox(height: 24),
                const Text(
                  "Sign in",
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 24),

                const SizedBox(height: 16),

                // Email
                CustomTextField(
                  controller: emailController,
                  hintText: "Email or phone number",
                ),
                const SizedBox(height: 16),
                CustomTextField(
                  obscureText: true,
                  controller: passwordController,
                  hintText: "Password",
                ),
                AppSpacing.sizedBox10,
                Align(
                  alignment: Alignment.centerRight,
                  child: GestureDetector(
                    onTap: () =>
                        NavigationHelper.push(context, ForgetPasswordScreen()),
                    child: CustomText(
                        text: "Forgot password?",
                        color: Colors.red,
                        fontSize: 14,
                        fontWeight: FontWeight.w500),
                  ),
                ),
                AppSpacing.sizedBox40,
                // Sign Up Button
                CustomButton(
                  text: "Sign In",
                  onPressed: () {
                    NavigationHelper.push(context, const HomeMapScreen());
                  },
                ),
                const SizedBox(height: 20),

                // Or divider
                Row(
                  children: const [
                    Expanded(child: Divider()),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 8.0),
                      child: Text("or"),
                    ),
                    Expanded(child: Divider()),
                  ],
                ),
                const SizedBox(height: 16),

                // Social icons
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    socialIcon("assets/images/gmail.png"),
                    const SizedBox(width: 16),
                    socialIcon("assets/images/Facebook.png"),
                    const SizedBox(width: 16),
                    socialIcon("assets/images/Apple.png"),
                  ],
                ),
                const SizedBox(height: 24),

                // Already have account
                Center(
                  child: GestureDetector(
                    onTap: () =>
                        NavigationHelper.push(context, CreateAccountScreen()),
                    child: Text.rich(
                      TextSpan(
                        text: "Don't have an account? ",
                        children: [
                          TextSpan(
                            text: "Sign Up",
                            style: TextStyle(
                              color: AppColors.primary,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget socialIcon(String path) {
    return Container(
      width: 48,
      height: 48,
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Image.asset(path),
    );
  }
}
