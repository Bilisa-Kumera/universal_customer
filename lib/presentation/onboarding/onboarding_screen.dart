import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../core/constants/widgets/custom_text.dart';
import '../../core/utils/navigation_helper.dart';
import '../welcome/enable_location.dart';
import '../welcome/welcome_screen.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _controller = PageController();
  int currentIndex = 0;

  final List<Map<String, String>> onboardingData = [
    {
      'image': 'assets/images/onboarding1.png',
      'title': 'Anywhere you are',
      'desc': 'Sell houses easily with the help of Listanyone and enjoy...'
    },
    {
      'image': 'assets/images/onboarding2.png',
      'title': 'At anytime',
      'desc': 'Sell houses easily with the help of Listanyone and enjoy...'
    },
    {
      'image': 'assets/images/onboarding3.png',
      'title': 'Book your car',
      'desc': 'Sell houses easily with the help of Listanyone and enjoy...'
    },
  ];

  void nextPage() {
    if (currentIndex < onboardingData.length - 1) {
      _controller.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeIn,
      );
    } else {
      NavigationHelper.pushReplacement(
        context,
        const EnableLocationScreen(),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView.builder(
        controller: _controller,
        itemCount: onboardingData.length,
        onPageChanged: (index) {
          setState(() => currentIndex = index);
        },
        itemBuilder: (context, index) {
          final item = onboardingData[index];
          return Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 60.h),
            child: Column(
              children: [
                Align(
                  alignment: Alignment.topRight,
                  child: TextButton(
                    onPressed: () {
                      NavigationHelper.pushReplacement(
                        context,
                        const WelcomeScreen(),
                      );
                    },
                    child: CustomText(
                      text: 'Skip',
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w400,
                      color: Colors.black,
                      textAlign: TextAlign.center,
                      letterSpacing: 1.2,
                      height: 1.4,
                    ),
                  ),
                ),
                SizedBox(height: 40.h),
                Image.asset(
                  item['image']!,
                  height: 200.h,
                ),
                SizedBox(height: 30.h),
                CustomText(
                  text: item['title'] ?? '',
                  fontSize: 24.sp,
                  fontWeight: FontWeight.w600,
                  color: Color(0xff2A2A2A),
                  textAlign: TextAlign.center,
                  letterSpacing: 1.2,
                  height: 1.4,
                ),
                SizedBox(height: 16.h),
                CustomText(
                  text: item['desc'] ?? '',
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w500,
                  color: Color(0xffA0A0A0),
                  textAlign: TextAlign.center,
                  letterSpacing: 1.2,
                  height: 1.4,
                ),
                const Spacer(),
                GestureDetector(
                  onTap: nextPage,
                  child: SizedBox(
                    width: 60.w,
                    height: 60.w,
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        // Progress arc
                        CustomPaint(
                          size: Size(60.w, 60.w),
                          painter: _ProgressArcPainter(
                            progress:
                                (currentIndex + 1) / onboardingData.length,
                          ),
                        ),
                        // Inner circle button
                        Container(
                          width: 48.w,
                          height: 48.w,
                          decoration: BoxDecoration(
                            color: Colors.amber,
                            shape: BoxShape.circle,
                          ),
                          child: Center(
                            child: currentIndex < onboardingData.length - 1
                                ? const Icon(Icons.arrow_forward,
                                    color: Colors.black)
                                : const Text('Go',
                                    style: TextStyle(color: Colors.black)),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class _ProgressArcPainter extends CustomPainter {
  final double progress; // 0.0 to 1.0
  _ProgressArcPainter({required this.progress});

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..color = Colors.amber.withOpacity(0.7)
      ..strokeWidth = 3
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    final Rect rect = Offset(0, 0) & size;
    canvas.drawArc(
      rect.deflate(3),
      -1.5708, // -pi/2, start at top
      6.2832 * progress, // 2*pi*progress
      false,
      paint,
    );
  }

  @override
  bool shouldRepaint(covariant _ProgressArcPainter oldDelegate) {
    return oldDelegate.progress != progress;
  }
}
