import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';

class OnboardingPage extends StatefulWidget {
  const OnboardingPage({super.key});

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  @override
  Widget build(BuildContext context) {
    final slides = [
      _buildSlide(
        title: 'Transforme ideias em',
        accent: 'aprovação',
        subtitle:
            'Organize projetos, acompanhe tarefas e mostre resultados com clareza.',
        buttonLabel: 'Continuar',
      ),
      _buildSlide(
        title: 'Pronto para começar?',
        accent: 'agora',
        subtitle:
            'Crie sua conta e veja como o RedaFácil pode simplificar sua rotina.',
        buttonLabel: 'Entrar',
      ),
    ];

    return Scaffold(
      backgroundColor: AppColors.background,
      body: Stack(
        children: [
          Positioned.fill(
            child: Opacity(
              opacity: 0.40,
              child: Image.asset(
                'assets/images/FirstImage.png',
                fit: BoxFit.cover,
              ),
            ),
          ),
          Positioned.fill(
            child: DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.black.withOpacity(0.2),
                    Colors.black.withOpacity(0.72),
                  ],
                ),
              ),
            ),
          ),
          SafeArea(
            child: Column(
              children: [
                const SizedBox(height: 36),
                Padding(
                  padding: const EdgeInsets.fromLTRB(32, 24, 24, 0),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Image.asset('assets/images/icone.png', height: 125),
                  ),
                ),
                Expanded(
                  child: PageView(
                    controller: _pageController,
                    onPageChanged: (index) {
                      setState(() {
                        _currentPage = index;
                      });
                    },
                    children: slides,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 24),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(
                      slides.length,
                      (index) => AnimatedContainer(
                        duration: const Duration(milliseconds: 250),
                        width: _currentPage == index ? 22 : 8,
                        height: 8,
                        margin: const EdgeInsets.symmetric(horizontal: 4),
                        decoration: BoxDecoration(
                          color: _currentPage == index
                              ? AppColors.primary
                              : Colors.white54,
                          borderRadius: BorderRadius.circular(999),
                        ),
                      ),
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

  Widget _buildSlide({
    required String title,
    required String accent,
    required String subtitle,
    required String buttonLabel,
  }) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 24, 24, 32),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          RichText(
            text: TextSpan(
              style: const TextStyle(
                fontSize: 36,
                fontWeight: FontWeight.bold,
                height: 1.1,
              ),
              children: [
                const TextSpan(
                  text: 'Transforme ideias em',
                  style: TextStyle(color: Colors.white),
                ),
                const TextSpan(text: '\n'),
                TextSpan(
                  text: accent,
                  style: const TextStyle(color: AppColors.primary),
                ),
              ],
            ),
          ),
          const SizedBox(height: 14),
          Text(
            subtitle,
            style: const TextStyle(
              color: Colors.white70,
              fontSize: 16,
              height: 1.5,
            ),
          ),
          const SizedBox(height: 28),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                if (_currentPage < 1) {
                  _pageController.nextPage(
                    duration: const Duration(milliseconds: 400),
                    curve: Curves.easeInOut,
                  );
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                foregroundColor: AppColors.white,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
              ),
              child: Text(
                buttonLabel,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
