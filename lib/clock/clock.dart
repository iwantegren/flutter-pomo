import 'dart:math';
import 'package:flutter/material.dart';

class ClockCircle extends StatelessWidget {
  static const int cycleLength = 60;

  const ClockCircle({super.key, required this.counter});

  final int counter;

  @override
  Widget build(BuildContext context) {
    final minutes = (counter ~/ 60).toString().padLeft(2, '0');
    final seconds = (counter % 60).toString().padLeft(2, '0');
    final activeDots = counter % 60;

    return Container(
      width: 250,
      height: 250,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primaryContainer,
        shape: BoxShape.circle,
      ),
      child: CustomPaint(
        painter: DotsPainter(
          totalDots: cycleLength,
          activeDots: activeDots,
          dotColor: Theme.of(context).colorScheme.onPrimaryContainer,
        ),
        child: Center(
          child: Text(
            '$minutes:$seconds',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              fontSize: 48,
              color: Theme.of(context).colorScheme.onPrimaryContainer,
            ),
          ),
        ),
      ),
    );
  }
}

class DotsPainter extends CustomPainter {
  final int totalDots;
  final int activeDots;
  final Color dotColor;

  DotsPainter({
    required this.totalDots,
    required this.activeDots,
    required this.dotColor,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = (size.width / 2) - 10; // Padding for dots
    final dotRadius = 3.0;

    for (int i = 0; i < totalDots; i++) {
      if (i >= activeDots) continue;

      // Start from top (-pi/2) and go clockwise
      final angle = (2 * pi * i / totalDots) - (pi / 2);
      final x = center.dx + radius * cos(angle);
      final y = center.dy + radius * sin(angle);

      final paint = Paint()
        ..color = dotColor
        ..style = PaintingStyle.fill;

      canvas.drawCircle(Offset(x, y), dotRadius, paint);
    }
  }

  @override
  bool shouldRepaint(covariant DotsPainter oldDelegate) {
    return oldDelegate.activeDots != activeDots ||
        oldDelegate.dotColor != dotColor;
  }
}
