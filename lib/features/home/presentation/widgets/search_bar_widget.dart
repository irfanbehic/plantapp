import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:plantapp/core/constants/app_colors.dart';

class SearchBarWidget extends StatelessWidget {
  const SearchBarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 44,
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.searchBarBorder),
      ),
      child: Row(
        children: [
          const SizedBox(width: 16),
          const Icon(Icons.search, color: AppColors.textHint, size: 20),
          const SizedBox(width: 8),
          Expanded(
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Search for plants',
                hintStyle: GoogleFonts.rubik(
                  fontSize: 15.5,
                  fontWeight: FontWeight.w400,
                  color: const Color(0xFFAFAFAF),
                  letterSpacing: 0.07,
                ),
                border: InputBorder.none,
                enabledBorder: InputBorder.none,
                focusedBorder: InputBorder.none,
                filled: false,
                contentPadding: EdgeInsets.zero,
                isDense: true,
              ),
              style: GoogleFonts.rubik(
                fontSize: 15.5,
                color: AppColors.textPrimary,
              ),
            ),
          ),
          const SizedBox(width: 16),
        ],
      ),
    );
  }
}
