import 'package:flutter/material.dart';
import 'package:universal_customer/core/constants/spacings.dart';
import 'package:universal_customer/core/constants/widgets/custom_button.dart';
import 'package:universal_customer/core/constants/widgets/custom_text.dart';
import 'package:universal_customer/core/utils/navigation_helper.dart';
import 'package:universal_customer/presentation/search/search_screen.dart';

class WaitingDriverScreen extends StatelessWidget {
  const WaitingDriverScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () {},
        ),
        title: CustomText(text: 'Back'), // Title is not visible in the image
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Spacer(),
            Image.asset(
              'assets/images/waiting.png', // Replace with your image asset path
              height: 200,
            ),
            const SizedBox(height: 24),
            CustomText(
              text: 'Waiting for nearby driver',
              fontSize: 20,
              fontWeight: FontWeight.w600,
              color: Color(0xff5A5A5A),
            ),
            const SizedBox(height: 48),
            Spacer(),
            Padding(
              padding: EdgeInsets.all(10),
              child: CustomButton(
                onPressed: () {
                  NavigationHelper.push(context, SearchScreen());
                },
                color: Colors.amber,
                text: 'Cancel Order',
              ),
            ),
            AppSpacing.sizedBox20,
          ],
        ),
      ),
    );
  }
}
