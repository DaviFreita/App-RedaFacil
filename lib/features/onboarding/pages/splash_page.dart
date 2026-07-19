import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/widgets/loading_indicator.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  late Animation<double> _scaleAnimation;

  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,

      duration: const Duration(milliseconds: 1200),
    );

    _scaleAnimation = Tween<double>(
      begin: 0.7,

      end: 1,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));

    _fadeAnimation = Tween<double>(
      begin: 0,

      end: 1,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeIn));

    _controller.forward();

    Future.delayed(const Duration(seconds: 3), () {
      if (mounted) {
        context.go('/onboarding');
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,

      body: Center(
        child: FadeTransition(
          opacity: _fadeAnimation,

          child: ScaleTransition(
            scale: _scaleAnimation,

            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,

              children: [
                // Logo
                Container(
                  width: 125,

                  height: 125,

                  child: Center(
                    child: SvgPicture.asset("assets/icons/icone.svg"),
                  ),
                ),

                Container(
                  width: 200,

                  height: 200,

                  child: Center(
                    child: Image.asset("assets/images/FraseHorizontal.png"),
                  ),
                ),

                const SizedBox(height: 40),

                const LoadingIndicator(),

                const SizedBox(height: 20),

                Text(
                  "Carregando...",

                  style: TextStyle(color: Colors.white70, fontSize: 12),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
