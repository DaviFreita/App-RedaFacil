import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';

class LoadingIndicator extends StatefulWidget {
  const LoadingIndicator({super.key});

  @override
  State<LoadingIndicator> createState() => _LoadingIndicatorState();
}

class _LoadingIndicatorState extends State<LoadingIndicator>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    )..repeat();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (_, __) {
        return Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            _dot(AppColors.blue, 0.0),
            const SizedBox(width: 12),
            _dot(AppColors.yellow, 0.2),
            const SizedBox(width: 12),
            _dot(AppColors.primary, 0.4),
          ],
        );
      },
    );
  }

  Widget _dot(Color color, double delay) {
    double value = (_controller.value + delay) % 1;

    final translate = -8 * (1 - (value * 2 - 1).abs());

    final opacity = 0.5 + (1 - (value * 2 - 1).abs()) * 0.5;

    return Transform.translate(
      offset: Offset(0, translate),
      child: Opacity(
        opacity: opacity,
        child: Container(
          width: 12,
          height: 12,
          decoration: BoxDecoration(color: color, shape: BoxShape.circle),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
