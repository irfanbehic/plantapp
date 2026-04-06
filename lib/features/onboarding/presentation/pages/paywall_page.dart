import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:plantapp/core/constants/app_colors.dart';
import 'package:plantapp/core/constants/app_text_styles.dart';
import 'package:plantapp/core/router/app_router.dart';
import 'package:plantapp/core/services/prefs_service.dart';

@RoutePage()
class PaywallPage extends StatefulWidget {
  const PaywallPage({super.key});

  @override
  State<PaywallPage> createState() => _PaywallPageState();
}

class _PaywallPageState extends State<PaywallPage> {
  int _selectedPlan = 1;

  Future<void> _closePaywall() async {
    await PrefsService.instance.setOnboardingCompleted();
    if (mounted) {
      context.router.replaceAll([const HomeRoute()]);
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);

    return Scaffold(
      backgroundColor: AppColors.paywallBackground,
      body: Stack(
        children: [
          SizedBox(
            width: double.infinity,
            height: size.height * 0.58,
            child: Image.asset(
              'assets/images/paywall_screen.png',
              fit: BoxFit.cover,
              alignment: Alignment.topCenter,
            ),
          ),
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.transparent,
                  AppColors.paywallBackground.withValues(alpha: 0.1),
                  AppColors.paywallBackground.withValues(alpha: 0.7),
                  AppColors.paywallBackground,
                  AppColors.paywallBackground,
                ],
                stops: const [0.0, 0.2, 0.45, 0.65, 1.0],
              ),
            ),
          ),
          SafeArea(
            child: Column(
              children: [
                Align(
                  alignment: Alignment.topRight,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(0, 4, 16, 0),
                    child: GestureDetector(
                      onTap: _closePaywall,
                      child: Container(
                        width: 26,
                        height: 26,
                        decoration: BoxDecoration(
                          color: Colors.black.withValues(alpha: 0.4),
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.close,
                          color: Colors.white,
                          size: 14,
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: size.height * 0.28),

                        RichText(
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text: 'PlantApp',
                                style: AppTextStyles.paywallBrand,
                              ),
                              TextSpan(
                                text: ' Premium',
                                style: AppTextStyles.paywallBrandLight,
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 4),

                        Text(
                          'Access All Features',
                          style: AppTextStyles.paywallSubtitle,
                        ),
                        const SizedBox(height: 20),

                        Row(
                          children: [
                            Expanded(
                              child: _FeatureCard(
                                iconWidget: SvgPicture.asset(
                                  'assets/icons/unlimited.svg',
                                  width: 36,
                                  height: 36,
                                ),
                                title: 'Unlimited',
                                subtitle: 'Plant Identify',
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: _FeatureCard(
                                iconWidget: SvgPicture.asset(
                                  'assets/icons/faster.svg',
                                  width: 36,
                                  height: 36,
                                ),
                                title: 'Faster',
                                subtitle: 'Process',
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 24),

                        _PlanOption(
                          label: '1 Month',
                          price: '\$2.99/month, auto renewable',
                          priceWeight: FontWeight.w400,
                          isSelected: _selectedPlan == 0,
                          onTap: () => setState(() => _selectedPlan = 0),
                        ),
                        const SizedBox(height: 16),
                        _PlanOption(
                          label: '1 Year',
                          price: 'First 3 days free, then \$529,99/year',
                          priceWeight: FontWeight.w400,
                          isSelected: _selectedPlan == 1,
                          saveBadge: 'Save 50%',
                          onTap: () => setState(() => _selectedPlan = 1),
                        ),
                        const SizedBox(height: 24),

                        SizedBox(
                          width: double.infinity,
                          height: 52,
                          child: ElevatedButton(
                            onPressed: _closePaywall,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.primary,
                              foregroundColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              elevation: 0,
                            ),
                            child: Text(
                              'Try free for 3 days',
                              style: AppTextStyles.buttonText,
                            ),
                          ),
                        ),
                        const SizedBox(height: 12),

                        SizedBox(
                          width: double.infinity,
                          child: Text(
                            'After the 3-day free trial period you\'ll be charged ₺274.99 per year unless you\ncancel before the trial expires. Yearly Subscription is Auto-Renewable.',
                            style: AppTextStyles.paywallFinePrint,
                            textAlign: TextAlign.center,
                          ),
                        ),
                        const SizedBox(height: 12),

                        Center(
                          child: Text(
                            'Terms  •  Privacy  •  Restore',
                            style: AppTextStyles.paywallTerms,
                          ),
                        ),
                        const SizedBox(height: 16),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _FeatureCard extends StatelessWidget {
  final Widget iconWidget;
  final String title;
  final String subtitle;

  const _FeatureCard({
    required this.iconWidget,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 124,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: Colors.white.withValues(alpha: 0.12),
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: [
          iconWidget,
          const SizedBox(height: 8),
          Text(title, style: AppTextStyles.paywallFeatureTitle),
          Text(subtitle, style: AppTextStyles.paywallFeatureSubtitle),
        ],
      ),
    );
  }
}

class _PlanOption extends StatelessWidget {
  final String label;
  final String price;
  final FontWeight priceWeight;
  final bool isSelected;
  final String? saveBadge;
  final VoidCallback onTap;

  const _PlanOption({
    required this.label,
    required this.price,
    required this.priceWeight,
    required this.isSelected,
    required this.onTap,
    this.saveBadge,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            decoration: BoxDecoration(
              color: isSelected
                  ? Colors.white.withValues(alpha: 0.12)
                  : Colors.white.withValues(alpha: 0.05),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: isSelected
                    ? AppColors.primary
                    : Colors.white.withValues(alpha: 0.15),
                width: isSelected ? 1.5 : 1,
              ),
            ),
            child: Row(
              children: [
                AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  width: 20,
                  height: 20,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: isSelected ? AppColors.primary : Colors.white38,
                      width: 2,
                    ),
                    color: isSelected ? AppColors.primary : Colors.transparent,
                  ),
                  child: isSelected
                      ? Center(
                          child: Container(
                            width: 8,
                            height: 8,
                            decoration: const BoxDecoration(
                              color: Colors.white,
                              shape: BoxShape.circle,
                            ),
                          ),
                        )
                      : null,
                ),
                const SizedBox(width: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      label,
                      style: isSelected
                          ? AppTextStyles.paywallPlanLabel
                          : AppTextStyles.paywallPlanLabelDim,
                    ),
                    Text(
                      price,
                      style: AppTextStyles.bodySmall.copyWith(
                        fontWeight: priceWeight,
                        color: isSelected
                            ? const Color(0xB3FFFFFF)
                            : Colors.white38,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          if (saveBadge != null)
            Positioned(
              top: 0,
              right: 0,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: AppColors.primary,
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(12),
                    topRight: Radius.circular(12),
                  ),
                ),
                child: Text(
                  saveBadge!,
                  style: AppTextStyles.bodySmall.copyWith(
                    fontWeight: FontWeight.w400,
                    color: Colors.white,
                    height: 1.5,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
