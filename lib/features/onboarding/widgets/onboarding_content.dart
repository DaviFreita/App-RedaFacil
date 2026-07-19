import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';
import '../model/onboarding_model.dart';

class OnboardingContent extends StatelessWidget {
  final OnboardingModel page;

  const OnboardingContent({super.key, required this.page});

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        /// IMAGEM
        Image.asset(page.image, fit: BoxFit.cover),

        /// ESCURECIMENTO
        Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              stops: const [0.0, 0.55, 1.0],
              colors: [
                Colors.black.withOpacity(.15),
                Colors.black.withOpacity(.25),
                AppColors.background,
              ],
            ),
          ),
        ),

        /// TEXTO
        SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 28),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 500),

                RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: "${page.title}\n",
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 42,
                          fontWeight: FontWeight.w800,
                          height: 1.15,
                        ),
                      ),

                      TextSpan(
                        text: page.highlight,
                        style: const TextStyle(
                          color: AppColors.primary,
                          fontSize: 42,
                          fontWeight: FontWeight.w800,
                          height: 1.15,
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 120),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
