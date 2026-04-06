import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:plantapp/core/constants/app_colors.dart';
import 'package:plantapp/core/constants/app_text_styles.dart';
import 'package:plantapp/features/home/data/models/category_model.dart';

class CategoryCardWidget extends StatelessWidget {
  final CategoryModel category;

  const CategoryCardWidget({super.key, required this.category});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.divider),
      ),
      clipBehavior: Clip.hardEdge,
      child: Stack(
        children: [
          Positioned(
            bottom: 0,
            right: 0,
            child: _CategoryImage(
              imageUrl: category.image?.url,
              width: category.image?.width,
              height: category.image?.height,
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(12, 12, 0, 0),
            child: Text(
              category.title,
              style: AppTextStyles.categoryTitle.copyWith(
                fontSize: 16,
                height: 1.3125,
              ),
              maxLines: 2,
            ),
          ),
        ],
      ),
    );
  }
}

class _CategoryImage extends StatelessWidget {
  final String? imageUrl;
  final int? width;
  final int? height;

  const _CategoryImage({this.imageUrl, this.width, this.height});

  @override
  Widget build(BuildContext context) {
    final w = width?.toDouble() ?? 88;
    final h = height?.toDouble() ?? 88;

    if (imageUrl == null) {
      return SizedBox(width: w, height: h);
    }

    return CachedNetworkImage(
      imageUrl: imageUrl!,
      width: w,
      height: h,
      fit: BoxFit.contain,
      placeholder: (_, __) => SizedBox(width: w, height: h),
      errorWidget: (_, __, ___) => SizedBox(width: w, height: h),
    );
  }
}
