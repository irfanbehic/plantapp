import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:plantapp/core/constants/app_colors.dart';
import 'package:plantapp/core/constants/app_text_styles.dart';
import 'package:plantapp/core/router/app_router.dart';
import 'package:plantapp/features/onboarding/presentation/bloc/onboarding_cubit.dart';
import 'package:plantapp/features/onboarding/presentation/bloc/onboarding_state.dart';

@RoutePage()
class OnboardingPage extends StatefulWidget {
  const OnboardingPage({super.key});

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  late final PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => OnboardingCubit(),
      child: BlocListener<OnboardingCubit, OnboardingState>(
        listener: (context, state) {
          if (state.isCompleted) {
            context.router.replace(const HomeRoute());
          } else {
            _pageController.animateToPage(
              state.currentPage,
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeInOut,
            );
          }
        },
        child: BlocBuilder<OnboardingCubit, OnboardingState>(
          builder: (context, state) {
            return Scaffold(
              body: LayoutBuilder(
                builder: (context, constraints) {
                  final bodyHeight = constraints.maxHeight;
                  final bottomAreaHeight = bodyHeight * (130 / 800);
                  final imageAreaHeight = bodyHeight - bottomAreaHeight;

                  return Stack(
                    children: [
                      PageView(
                        controller: _pageController,
                        onPageChanged: (index) {
                          context.read<OnboardingCubit>().goToPage(index);
                        },
                        children: [
                          _OnboardingFirstPage(
                            imageAreaHeight: imageAreaHeight,
                            bodyHeight: bodyHeight,
                          ),
                          _OnboardingSecondPage(
                            imageAreaHeight: imageAreaHeight,
                            bodyHeight: bodyHeight,
                          ),
                        ],
                      ),
                      _BottomArea(
                        bottomAreaHeight: bottomAreaHeight,
                        currentPage: state.currentPage,
                        onContinue: () {
                          if (state.currentPage == 0) {
                            context.read<OnboardingCubit>().nextPage();
                          } else {
                            context.router.push(const PaywallRoute());
                          }
                        },
                      ),
                    ],
                  );
                },
              ),
            );
          },
        ),
      ),
    );
  }
}

class _BottomArea extends StatelessWidget {
  final double bottomAreaHeight;
  final int currentPage;
  final VoidCallback onContinue;

  const _BottomArea({
    required this.bottomAreaHeight,
    required this.currentPage,
    required this.onContinue,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
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
                onPressed: onContinue,
                child: Text('Continue', style: AppTextStyles.buttonText),
              ),
            ),
            const SizedBox(height: 16),
            _PageIndicator(currentPage: currentPage),
          ],
        ),
      ),
    );
  }
}

class _PageIndicator extends StatelessWidget {
  final int currentPage;

  const _PageIndicator({required this.currentPage});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        3,
        (index) {
          final isActive = index == currentPage;
          return AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            margin: const EdgeInsets.symmetric(horizontal: 3),
            width: isActive ? 10 : 6,
            height: isActive ? 10 : 6,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: isActive
                  ? AppColors.textPrimary
                  : AppColors.textDotInactive,
            ),
          );
        },
      ),
    );
  }
}

class _OnboardingFirstPage extends StatelessWidget {
  final double imageAreaHeight;
  final double bodyHeight;

  const _OnboardingFirstPage({
    required this.imageAreaHeight,
    required this.bodyHeight,
  });

  @override
  Widget build(BuildContext context) {
    final textTopOffset = bodyHeight * (46 / 800);

    return Stack(
      children: [
        Positioned(
          top: 0,
          left: 0,
          right: 0,
          height: imageAreaHeight,
          child: Container(
            color: AppColors.onboardingBackground,
            child: Transform.translate(
              offset: const Offset(0, 75),
              child: Transform.scale(
                scale: 1.0,
                child: Image.asset(
                  'assets/images/onboarding_first.png',
                  fit: BoxFit.fitWidth,
                ),
              ),
            ),
          ),
        ),
        Positioned(
          top: textTopOffset,
          left: 20,
          right: 20,
          child: RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: 'Take a photo to ',
                  style: AppTextStyles.onboarding1Title,
                ),
                WidgetSpan(
                  alignment: PlaceholderAlignment.baseline,
                  baseline: TextBaseline.alphabetic,
                  child: Stack(
                    clipBehavior: Clip.none,
                    children: [
                      Text(
                        'identify',
                        style: AppTextStyles.onboarding1TitleBold,
                      ),
                      Positioned(
                        left: 0,
                        bottom: -5,
                        child: Transform(
                          transform: Matrix4.identity()
                            ..setEntry(1, 0, 0.06)
                            ..setEntry(0, 1, -0.08),
                          child: CustomPaint(
                            size: const Size(138, 12),
                            painter: _WavyUnderlinePainter(),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                TextSpan(
                  text: '\nthe plant!',
                  style: AppTextStyles.onboarding1Title,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _WavyUnderlinePainter extends CustomPainter {
  final double strokeWidth;

  _WavyUnderlinePainter({this.strokeWidth = 1.5});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = const Color(0xFF13231B)
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    final path = Path();
    path.moveTo(0, size.height);
    path.quadraticBezierTo(size.width / 2, 0, size.width, size.height);

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}

class _OnboardingSecondPage extends StatelessWidget {
  final double imageAreaHeight;
  final double bodyHeight;

  const _OnboardingSecondPage({
    required this.imageAreaHeight,
    required this.bodyHeight,
  });

  @override
  Widget build(BuildContext context) {
    final textTopOffset = bodyHeight * (46 / 800);

    return Stack(
      children: [
        Positioned(
          top: 23,
          left: 0,
          right: 0,
          height: imageAreaHeight,
          child: Container(
            decoration: const BoxDecoration(
              color: Colors.white,
            ),
            child: Image.asset(
              'assets/images/onboarding_second.png',
              fit: BoxFit.contain,
              alignment: Alignment.center,
            ),
          ),
        ),
        Positioned(
          top: textTopOffset,
          left: 20,
          right: 20,
          child: RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: 'Get plant ',
                  style: AppTextStyles.onboarding1Title,
                ),
                WidgetSpan(
                  alignment: PlaceholderAlignment.baseline,
                  baseline: TextBaseline.alphabetic,
                  child: Stack(
                    clipBehavior: Clip.none,
                    children: [
                      Text(
                        'care guides',
                        style: AppTextStyles.onboarding1TitleBold,
                      ),
                      Positioned(
                        left: 40,
                        bottom: -5,
                        child: Transform(
                          transform: Matrix4.identity()
                            ..setEntry(1, 0, 0.06)
                            ..setEntry(0, 1, -0.08),
                          child: CustomPaint(
                            size: const Size(140, 12),
                            painter: _WavyUnderlinePainter(strokeWidth: 1.5),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
