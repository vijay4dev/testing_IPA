import 'package:flutter/material.dart';
import 'dart:ui' as ui;
import 'dart:math';

class GradientProgressArc extends StatelessWidget {
  final double progress; // Value between 0.0 to 1.0
  final double rating;
  final String reviewCount;

  GradientProgressArc({required this.progress, required this.rating, required this.reviewCount});

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: Size(200, 150), // Adjust to fit your UI
      painter: ArcPainter(progress),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            rating.toString(),
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 5),
          Text(
            reviewCount,
            style: TextStyle(fontSize: 12, color: Colors.grey),
          ),
        ],
      ),
    );
  }
}

class ArcPainter extends CustomPainter {
  final double progress; // Should be between 0.0 and 1.0

  ArcPainter(this.progress);

  @override
  void paint(Canvas canvas, Size size) {
    double width = size.width;
    double height = size.height;
    double radius = min(width, height) / 1.2; // Adjust radius to fit UI
    Offset center = Offset(width / 2, height); // Adjust position

    Rect rect = Rect.fromCircle(center: center, radius: radius);
    Gradient gradient = LinearGradient(
      colors: [Colors.blue, Colors.green, Colors.yellow, Colors.grey],
    );

    Paint dottedArcPaint = Paint()
      ..color = Colors.grey.withOpacity(0.3)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 6
      ..strokeCap = StrokeCap.round;

    Paint gradientPaint = Paint()
      ..shader = gradient.createShader(rect)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 8
      ..strokeCap = StrokeCap.round;

    // Draw the dotted arc (background)
    canvas.drawArc(rect, pi, pi, false, dottedArcPaint);

    // Draw the gradient arc (progress)
    canvas.drawArc(rect, pi, progress * pi, false, gradientPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
