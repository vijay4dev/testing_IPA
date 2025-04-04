import 'package:butterflix/movie_detail/ratin_meter.dart';
import 'package:flutter/material.dart';

class RatingGaugeDemo extends StatelessWidget {
  const RatingGaugeDemo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Get screen size for responsive layout
    final screenSize = MediaQuery.of(context).size;

    // Calculate responsive sizes
    double gaugeWidth = 228;
    double gaugeHeight = 237;

    // Adjust size for different screen sizes
    if (screenSize.width <= 640) {
      gaugeWidth = 280;
      gaugeHeight = 200;
    } else if (screenSize.width <= 991) {
      gaugeWidth = 200;
      gaugeHeight = 208;
    }

    return Scaffold(
      // backgroundColor: Colors.white,
      body: Center(
        child: RatingGauge(
          rating: 7.8,
          ratedText: '10k Rated',
          width: gaugeWidth,
          height: gaugeHeight,
        ),
      ),
    );
  }
}
