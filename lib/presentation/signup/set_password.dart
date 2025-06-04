import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:universal_customer/core/constants/widgets/custom_text.dart';
import 'package:universal_customer/core/utils/navigation_helper.dart';
import 'package:universal_customer/presentation/login/login_screen.dart';
import '../../core/constants/colors.dart';
import '../../core/constants/spacings.dart';
import '../../core/constants/widgets/custom_button.dart';
import '../../core/constants/widgets/custom_textinput.dart';

class SetPasswordScreen extends StatefulWidget {
  const SetPasswordScreen({super.key});

  @override
  State<SetPasswordScreen> createState() => _SetPasswordScreenState();
}

class _SetPasswordScreenState extends State<SetPasswordScreen> {
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () => Navigator.pop(context),
        ),
        title: CustomText(text: 'Back'),
        systemOverlayStyle: SystemUiOverlayStyle.dark,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(AppSpacing.lg),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const CustomText(
                  text: 'Set password',
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
                AppSpacing.sizedBox10,
                const CustomText(
                  text: 'Set your password',
                  color: AppColors.greyText,
                  fontSize: 16,
                ),
                AppSpacing.sizedBox40,
                CustomTextField(
                  controller: _passwordController,
                  hintText: 'Enter Your Password',
                  obscureText: _obscurePassword,
                  suffixIcon: IconButton(
                    icon: Icon(
                      _obscurePassword
                          ? Icons.visibility_off
                          : Icons.visibility,
                      color: AppColors.greyText,
                    ),
                    onPressed: () {
                      setState(() {
                        _obscurePassword = !_obscurePassword;
                      });
                    },
                  ),
                ),
                AppSpacing.sizedBox20,
                CustomTextField(
                  controller: _confirmPasswordController,
                  hintText: 'Confirm Password',
                  obscureText: _obscureConfirmPassword,
                  suffixIcon: IconButton(
                    icon: Icon(
                      _obscureConfirmPassword
                          ? Icons.visibility_off
                          : Icons.visibility,
                      color: AppColors.greyText,
                    ),
                    onPressed: () {
                      setState(() {
                        _obscureConfirmPassword = !_obscureConfirmPassword;
                      });
                    },
                  ),
                ),
                AppSpacing.sizedBox10,
                const CustomText(
                  text: 'At least 1 number or a special character',
                  color: AppColors.greyText,
                  fontSize: 12,
                ),
                SizedBox(height: 40),
                AppSpacing.sizedBox40,
                CustomButton(
                  text: "Set Password",
                  onPressed: () {
                    NavigationHelper.push(context, LoginScreen());
                    final password = _passwordController.text;
                    final confirmPassword = _confirmPasswordController.text;
                    final passwordValid = password.length >= 6 &&
                        RegExp(r'[0-9!@#\$%^&*(),.?":{}|<>]')
                            .hasMatch(password);
                    if (password != confirmPassword) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Passwords do not match')),
                      );
                    } else if (!passwordValid) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                            content: Text(
                                'Password must be at least 6 characters and contain a number or special character')),
                      );
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                            content: Text('Registration successful!')),
                      );
                      // Proceed with registration logic
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
