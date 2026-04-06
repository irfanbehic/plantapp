import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:plantapp/core/constants/app_colors.dart';
import 'package:plantapp/core/constants/app_text_styles.dart';
import 'package:plantapp/core/router/app_router.dart';

@RoutePage()
class GetStartedPage extends StatelessWidget {
  const GetStartedPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(
        builder: (context, constraints) {
          final bodyHeight = constraints.maxHeight;
          final bodyWidth = constraints.maxWidth;
          final imageAreaHeight = bodyHeight * (670 / 800);
          final bottomAreaHeight = bodyHeight * (130 / 800);
          final textTopOffset = bodyHeight * (46 / 800);

          return Stack(
            children: [
              Positioned(
                top: 0,
                left: 0,
                right: 0,
                height: imageAreaHeight,
                child: Image.asset(
                  'assets/images/get_started.png',
                  width: bodyWidth,
                  height: imageAreaHeight,
                  fit: BoxFit.cover,
                  alignment: Alignment.topCenter,
                ),
              ),

              Positioned(
                top: textTopOffset,
                left: 20,
                right: 20,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: 'Welcome to ',
                            style: AppTextStyles.onboardingTitle,
                          ),
                          TextSpan(
                            text: 'PlantApp',
                            style: AppTextStyles.onboardingTitleBold,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Identify more than 3000+ plants and 88%\naccuracy.',
                      style: AppTextStyles.onboardingSubtitle,
                    ),
                  ],
                ),
              ),

              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                height: bottomAreaHeight,
                child: Container(
                  color: Colors.white,
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: double.infinity,
                        height: 56,
                        child: ElevatedButton(
                          onPressed: () {
                            context.router.push(const OnboardingRoute());
                          },
                          child: Text('Get Started', style: AppTextStyles.buttonText),
                        ),
                      ),
                      const SizedBox(height: 16),
                      RichText(
                        textAlign: TextAlign.center,
                        text: TextSpan(
                          style: AppTextStyles.disclaimer,
                          children: [
                            const TextSpan(
                              text: 'By tapping next, you are agreeing to PlantID\n',
                            ),
                            TextSpan(
                              text: 'Terms of Use',
                              style: AppTextStyles.disclaimer.copyWith(
                                decoration: TextDecoration.underline,
                                decorationColor: AppColors.textDisclaimer,
                              ),
                            ),
                            const TextSpan(text: ' & '),
                            TextSpan(
                              text: 'Privacy Policy',
                              style: AppTextStyles.disclaimer.copyWith(
                                decoration: TextDecoration.underline,
                                decorationColor: AppColors.textDisclaimer,
                              ),
                            ),
                            const TextSpan(text: '.'),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
