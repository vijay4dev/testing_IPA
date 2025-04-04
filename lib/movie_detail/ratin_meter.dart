import 'dart:math';
import 'package:butterflix/utils/app_colors.dart';
import 'package:flutter/material.dart';

class RatingGauge extends StatelessWidget {
  final double rating;
  final String ratedText;
  final double width;
  final double height;

  const RatingGauge({
    Key? key,
    required this.rating,
    required this.ratedText,
    this.width = 240,
    this.height = 300,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Calculate responsive sizes based on the width
    final double fontSize = width * 0.13;
    final double subTextSize = width * 0.053;

    return SizedBox(
      width: width,
      height: height,
      child: Stack(
        alignment: Alignment.center,
        children: [
          // The gauge custom painter
          CustomPaint(
            size: Size(width, height),
            painter: RatingGaugePainter(
              rating: rating,
              maxRating: 10.0,
            ),
          ),

          // Rating text
          Positioned(
            top: height * 0.10,
            child: Text(
              rating.toString(),
              style: TextStyle(
                  fontSize: 45,
                  fontWeight: FontWeight.w500,
                  color: Theme.of(context).brightness == Brightness.light
                      ? Colors.grey[400]
                      : AppColors.playlist_btn_color),
              semanticsLabel: 'Rating: ${rating.toString()} out of 10',
            ),
          ),

          // Rated text
          Positioned(
            top: height * 0.43,
            child: Text(
              ratedText,
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                  color: Colors.grey),
            ),
          ),
        ],
      ),
    );
  }
}

class RatingGaugePainter extends CustomPainter {
  final double rating;
  final double maxRating;

  RatingGaugePainter({
    required this.rating,
    required this.maxRating,
  });

  @override

  // In the paint method, update the dotted circle radius multiplier to add space
  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = min(size.width, size.height) * 0.55;

    // Calculate the angle for the rating
    final double startAngle = pi;
    final double sweepAngle = pi * (rating / maxRating);

    // Increase the multiplier to add more gap between dotted and gradient circles
    final dottedRadius = radius * 1.2;
    _drawHalfDottedArc(canvas, center, dottedRadius, 2, 2);

    // Draw the background arc (gray)
    final backgroundPaint = Paint()
      ..color = const Color(0xFFD9D9D9)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 10.0
      ..strokeCap = StrokeCap.square;

    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      startAngle,
      pi,
      false,
      backgroundPaint,
    );

    // Draw the rating arc (gradient)
    final ratingPaint = Paint()
      ..shader = const LinearGradient(
        colors: [Color(0xFFE5C803), Color(0xFF004AAD)],
        begin: Alignment.centerRight,
        end: Alignment.centerLeft,
      ).createShader(Rect.fromCircle(center: center, radius: radius))
      ..style = PaintingStyle.stroke
      ..strokeWidth = 10.0
      ..strokeCap = StrokeCap.square;

    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      startAngle,
      sweepAngle,
      false,
      ratingPaint,
    );

    // Calculate the position of the indicator circle
    final indicatorAngle = startAngle + sweepAngle;
    final indicatorX = center.dx + radius * cos(indicatorAngle);
    final indicatorY = center.dy + radius * sin(indicatorAngle);
    final indicatorCenter = Offset(indicatorX, indicatorY);

    // Draw the indicator circle (white with blue border)
    final indicatorBorderPaint = Paint()
      ..color = const Color(0xFF004AAD)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3.0;
    final indicatorFillPaint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;
    canvas.drawCircle(indicatorCenter, 7.0, indicatorFillPaint);
    canvas.drawCircle(indicatorCenter, 7.0, indicatorBorderPaint);
  }

  void _drawHalfDottedArc(Canvas canvas, Offset center, double radius,
      double dashWidth, double dashSpace) {
    final paint = Paint()
      ..color = AppColors.Button_Yellow
      ..style = PaintingStyle.stroke
      ..strokeWidth = 0.9;

    final double startAngle = pi;
    final double sweepAngle = pi;
    final double dashAngle = dashWidth / radius;
    final double gapAngle = dashSpace / radius;
    double currentAngle = startAngle;

    while (currentAngle < startAngle + sweepAngle) {
      final double nextDashEnd = currentAngle + dashAngle;
      final double effectiveDashAngle = (nextDashEnd > startAngle + sweepAngle)
          ? startAngle + sweepAngle - currentAngle
          : dashAngle;
      canvas.drawArc(
        Rect.fromCircle(center: center, radius: radius),
        currentAngle,
        effectiveDashAngle,
        false,
        paint,
      );
      currentAngle += dashAngle + gapAngle;
    }
  }

  @override
  bool shouldRepaint(covariant RatingGaugePainter oldDelegate) {
    return oldDelegate.rating != rating || oldDelegate.maxRating != maxRating;
  }
}
