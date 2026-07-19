import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

import '../../../core/theme/app_colors.dart';
import '../model/onboarding_model.dart';
import '../widgets/login_bottom_sheet.dart';
import '../widgets/onboarding_content.dart';
import '../widgets/page_indicator.dart';

class OnboardingPage extends StatefulWidget {
  const OnboardingPage({super.key});

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  final PageController _pageController = PageController();

  int _currentPage = 0;
  bool _showLogin = false;

  final List<OnboardingModel> pages = const [
    OnboardingModel(
      image: "assets/images/FirstImage.png",
      title: "Transforme\nideias em",
      highlight: "aprovação.",
    ),
    OnboardingModel(
      image: "assets/images/SecondImage.png",
      title: "Seu futuro\ncomeça",
      highlight: "agora.",
    ),
  ];

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _next() {
    if (_currentPage == pages.length - 1) {
      setState(() {
        _showLogin = true;
      });
      return;
    }

    _pageController.nextPage(
      duration: const Duration(milliseconds: 350),
      curve: Curves.easeOut,
    );
  }

  void _backToOnboarding() {
    setState(() {
      _showLogin = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Stack(
        children: [
          AnimatedOpacity(
            opacity: _showLogin ? .75 : 1,
            duration: const Duration(milliseconds: 400),
            child: PageView.builder(
              controller: _pageController,
              physics: _showLogin
                  ? const NeverScrollableScrollPhysics()
                  : const BouncingScrollPhysics(),
              itemCount: pages.length,
              onPageChanged: (index) {
                setState(() {
                  _currentPage = index;
                });
              },
              itemBuilder: (_, index) {
                return GestureDetector(
                  onTap: _next,
                  child: OnboardingContent(page: pages[index]),
                );
              },
            ),
          ),

          Align(
            alignment: Alignment.topCenter,
            child: SafeArea(
              child: Padding(
                padding: const EdgeInsets.only(top: 40),
                child: SvgPicture.asset("assets/icons/icone.svg", width: 100),
              ),
            ),
          ),

          /// ===========================
          /// BOTÃO COMEÇAR
          /// ===========================
          AnimatedPositioned(
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeOut,
            bottom: _showLogin ? -120 : 95,
            left: 24,
            right: 24,
            child: AnimatedOpacity(
              opacity: (_currentPage == pages.length - 1 && !_showLogin)
                  ? 1
                  : 0,
              duration: const Duration(milliseconds: 250),
              child: IgnorePointer(
                ignoring: _currentPage != pages.length - 1,
                child: SizedBox(
                  height: 56,
                  child: FilledButton(
                    style: FilledButton.styleFrom(
                      backgroundColor: AppColors.primary,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18),
                      ),
                    ),
                    onPressed: () {
                      setState(() {
                        _showLogin = true;
                      });
                    },
                    child: const Text(
                      "Começar",
                      style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),

          /// ===========================
          /// INDICADOR FIXO
          /// ===========================
          AnimatedPositioned(
            duration: const Duration(milliseconds: 300),
            bottom: _showLogin ? -40 : 48,
            left: 0,
            right: 0,
            child: AnimatedOpacity(
              opacity: _showLogin ? 0 : 1,
              duration: const Duration(milliseconds: 250),
              child: Center(
                child: PageIndicator(
                  currentPage: _currentPage,
                  totalPages: pages.length,
                ),
              ),
            ),
          ),

          /// ===========================
          /// LOGIN BOTTOM SHEET
          /// ===========================
          LoginBottomSheet(
            visible: _showLogin,
            onClose: _backToOnboarding,
            onContinue: (email) {
              context.go("/password", extra: email);
            },
            onGoogleLogin: () {
              // TODO
            },
          ),
        ],
      ),
    );
  }
}
