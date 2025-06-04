import 'package:flutter/material.dart';
import 'package:universal_customer/core/constants/spacings.dart';
import 'package:universal_customer/core/utils/navigation_helper.dart';
import 'package:universal_customer/presentation/login/login_screen.dart';
import 'package:universal_customer/presentation/signup/create_account.dart';

import '../../core/constants/colors.dart';
import '../../core/constants/widgets/custom_button.dart';
import '../../core/constants/widgets/custom_text.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 60),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            AppSpacing.sizedBox20,
            const Image(image: AssetImage('assets/images/welcome.png')),
            Column(
              children: const [
                CustomText(
                    text: 'Welcome', fontSize: 22, fontWeight: FontWeight.bold),
                SizedBox(height: 10),
                CustomText(
                  text: 'Have a better sharing experience',
                  fontSize: 14,
                  color: AppColors.greyText,
                ),
              ],
            ),
            Column(
              children: [
                CustomButton(
                  text: 'Create Account',
                  onPressed: () {
                    NavigationHelper.push(context, CreateAccountScreen());
                  },
                  color: Color(0xFFEDAE10),
                  textColor: Colors.white,
                  // icon: const Icon(Icons.my_location,
                  //     color: Colors.white, size: 20),
                ),
                AppSpacing.sizedBox20,
                CustomButton(
                  text: 'Login',
                  onPressed: () {
                    NavigationHelper.push(context, LoginScreen());
                  },
                  borderColor: AppColors.primary,
                  color: Colors.white,
                  textColor: AppColors.primary,
                  // icon: const Icon(Icons.my_location,
                  //     color: Colors.white, size: 20),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
