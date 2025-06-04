import 'package:flutter/material.dart';
import 'package:universal_customer/core/constants/widgets/custom_button.dart';
import 'package:universal_customer/core/constants/widgets/custom_text.dart';
import 'package:universal_customer/core/utils/navigation_helper.dart';
import 'package:universal_customer/presentation/login/forget_password_verification.dart';

class ForgetPasswordScreen extends StatefulWidget {
  const ForgetPasswordScreen({super.key});

  @override
  State<ForgetPasswordScreen> createState() => _ForgetPasswordScreenState();
}

class _ForgetPasswordScreenState extends State<ForgetPasswordScreen> {
  int selectedIndex = 0;

  final List<Map<String, dynamic>> contactOptions = [
    {
      'icon': Icons.sms,
      'title': 'Via SMS',
      'subtitle': '***** ***70',
    },
    {
      'icon': Icons.email,
      'title': 'Via Email',
      'subtitle': '**** **** **** xyz@xyz.com',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: CustomText(text: 'Back'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 16),
            const Text(
              'Forgot Password',
              style: TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 12),
            const Text(
              'Select which contact details should we use to reset your password',
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey,
              ),
            ),
            const SizedBox(height: 32),
            SizedBox(
              height: 260,
              child: ListView.builder(
                itemCount: contactOptions.length,
                itemBuilder: (context, index) {
                  final option = contactOptions[index];
                  return Column(
                    children: [
                      _ContactOption(
                        icon: option['icon'],
                        title: option['title'],
                        subtitle: option['subtitle'],
                        selected: selectedIndex == index,
                        onTap: () {
                          setState(() {
                            selectedIndex = index;
                          });
                        },
                      ),
                      if (index != contactOptions.length - 1)
                        const SizedBox(height: 16),
                    ],
                  );
                },
              ),
            ),
            const Spacer(),
            CustomButton(
              text: 'Continue',
              onPressed: () {
                NavigationHelper.push(context, ForgetPasswordVerification());
              },
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}

class _ContactOption extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final bool selected;
  final VoidCallback? onTap;

  const _ContactOption({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.selected,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: selected ? const Color(0xFFFFF9E5) : const Color(0xFFF9F9F9),
        border: Border.all(
          color: selected ? const Color(0xFFF7B731) : Colors.transparent,
          width: 1.5,
        ),
        borderRadius: BorderRadius.circular(12),
      ),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor:
              selected ? const Color(0xFFFFF3C2) : const Color(0xFFEFEFEF),
          child: Icon(icon, color: const Color(0xFFF7B731)),
        ),
        title: Text(
          title,
          style: TextStyle(
            color: selected ? const Color(0xFFF7B731) : Colors.grey,
            fontWeight: FontWeight.w600,
          ),
        ),
        subtitle: Text(
          subtitle,
          style: const TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
        onTap: onTap,
      ),
    );
  }
}
