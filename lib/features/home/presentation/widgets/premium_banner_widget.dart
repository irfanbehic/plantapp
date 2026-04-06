import 'package:flutter/material.dart';
import 'package:plantapp/core/constants/app_colors.dart';
import 'package:plantapp/core/constants/app_text_styles.dart';

class PremiumBannerWidget extends StatelessWidget {
  const PremiumBannerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: AppColors.premiumBannerBackground,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Stack(
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: const Color(0xFF5C3E0A),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Icon(
                  Icons.mail_outlined,
                  color: Color(0xFFFFD700),
                  size: 22,
                ),
              ),
              Positioned(
                top: 0,
                right: 0,
                child: Container(
                  width: 12,
                  height: 12,
                  decoration: const BoxDecoration(
                    color: Color(0xFFE53935),
                    shape: BoxShape.circle,
                  ),
                  child: const Center(
                    child: Text(
                      '!',
                      style: TextStyle(
                        fontSize: 8,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ShaderMask(
                  shaderCallback: (bounds) => const LinearGradient(
                    colors: [Color(0xFFE5C990), Color(0xFFE4B046)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ).createShader(bounds),
                  child: Text(
                    'FREE Premium Available',
                    style: AppTextStyles.greetingSmall.copyWith(
                      color: Colors.white,
                      height: 1.3125,
                    ),
                  ),
                ),
                const SizedBox(height: 2),
                ShaderMask(
                  shaderCallback: (bounds) => const LinearGradient(
                    colors: [Color(0xFFFFDE9C), Color(0xFFF5C25B)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ).createShader(bounds),
                  child: Text(
                    'Tap to upgrade your account!',
                    style: AppTextStyles.categoryTitle.copyWith(
                      color: Colors.white.withValues(alpha: 0.8),
                      height: 1.23,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const Icon(Icons.chevron_right, color: Colors.white54, size: 20),
        ],
      ),
    );
  }
}
