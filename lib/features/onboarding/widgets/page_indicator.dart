import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';

class PageIndicator extends StatelessWidget {
  final int currentPage;
  final int totalPages;

  const PageIndicator({
    super.key,
    required this.currentPage,
    required this.totalPages,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(totalPages, (index) {
        final isSelected = currentPage == index;

        return AnimatedContainer(
          duration: const Duration(milliseconds: 250),
          curve: Curves.easeOut,
          margin: const EdgeInsets.symmetric(horizontal: 4),
          width: isSelected ? 26 : 8,
          height: 8,
          decoration: BoxDecoration(
            color: isSelected ? AppColors.primary : Colors.white24,
            borderRadius: BorderRadius.circular(30),
          ),
        );
      }),
    );
  }
}
