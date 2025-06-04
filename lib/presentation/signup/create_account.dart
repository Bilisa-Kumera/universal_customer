import 'package:flutter/material.dart';
import 'package:universal_customer/core/constants/colors.dart';
import 'package:universal_customer/core/utils/navigation_helper.dart';
import 'package:universal_customer/presentation/login/login_screen.dart';
import 'package:universal_customer/presentation/signup/phone_verification.dart';

import '../../core/constants/widgets/custom_button.dart';
import '../../core/constants/widgets/custom_textinput.dart';
import 'package:intl_phone_field/intl_phone_field.dart';

class CreateAccountScreen extends StatelessWidget {
  CreateAccountScreen({super.key});

  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController genderController = TextEditingController();
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
                  "Sign up",
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 24),

                // Name
                CustomTextField(
                  controller: nameController,
                  hintText: "Name",
                ),
                const SizedBox(height: 16),

                // Email
                CustomTextField(
                  controller: emailController,
                  hintText: "Email",
                ),
                const SizedBox(height: 16),

                IntlPhoneField(
                  decoration: InputDecoration(
                    hintText: 'Your mobile number',
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: Color(0xFFB8B8B8)),
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  initialCountryCode: 'ET', // 🇪🇹 Ethiopia
                  onChanged: (phone) {
                    completePhoneNumber = phone.completeNumber;
                  },
                ),

                const SizedBox(height: 16),

                // Gender
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: const Color(0xFFB8B8B8)),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: DropdownButtonFormField<String>(
                    decoration: const InputDecoration(
                      contentPadding: EdgeInsets.symmetric(horizontal: 12),
                      border: InputBorder.none,
                    ),
                    hint: const Text("Gender"),
                    value: genderController.text.isEmpty
                        ? null
                        : genderController.text,
                    items: const [
                      DropdownMenuItem(value: "Male", child: Text("Male")),
                      DropdownMenuItem(value: "Female", child: Text("Female")),
                    ],
                    onChanged: (value) {
                      if (value != null) {
                        genderController.text = value;
                      }
                    },
                  ),
                ),
                const SizedBox(height: 16),

                // Terms
                Row(
                  children: [
                    Checkbox(
                      value: true,
                      onChanged: (bool? value) {},
                      activeColor: Colors.green,
                      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    ),
                    const SizedBox(width: 8),
                    const Expanded(
                      child: Text.rich(
                        TextSpan(
                          text: "By signing up, you agree to the ",
                          style: TextStyle(fontSize: 13),
                          children: [
                            TextSpan(
                              text: "Terms of service",
                              style: TextStyle(
                                  color: Colors.orange,
                                  fontWeight: FontWeight.bold),
                            ),
                            TextSpan(text: " and "),
                            TextSpan(
                              text: "Privacy policy.",
                              style: TextStyle(
                                  color: Colors.green,
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 24),

                // Sign Up Button
                CustomButton(
                  text: "Sign Up",
                  onPressed: () {
                    NavigationHelper.push(
                        context, const PhoneVerificationScreen());
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
                        NavigationHelper.push(context, LoginScreen()),
                    child: Text.rich(
                      TextSpan(
                        text: "Already have an account? ",
                        children: [
                          TextSpan(
                            text: "Sign in",
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
