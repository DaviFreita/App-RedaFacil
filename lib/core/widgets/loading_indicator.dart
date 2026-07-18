import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';

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
        final value = _controller.value;

        return Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            _dot(AppColors.blue, value, 0.0),
            const SizedBox(width: 10),
            _dot(AppColors.yellow, value, 0.33),
            const SizedBox(width: 10),
            _dot(AppColors.primary, value, 0.66),
          ],
        );
      },
    );
  }

  Widget _dot(Color color, double value, double delay) {
    double animation = (value - delay);

    if (animation < 0) animation += 1;

    final scale = 0.7 + (1 - (animation * 2 - 1).abs()) * 0.6;

    return Transform.scale(
      scale: scale,
      child: Container(
        width: 12,
        height: 12,
        decoration: BoxDecoration(color: color, shape: BoxShape.circle),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
