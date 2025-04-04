import 'package:butterflix/utils/app_images.dart';
import 'package:butterflix/utils/extension.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class CarouselWidget extends StatefulWidget {
  const CarouselWidget({super.key, required this.is_autoplay});
  final bool is_autoplay;
  @override
  State<CarouselWidget> createState() => _CarouselWidgetState();
}

class _CarouselWidgetState extends State<CarouselWidget> {
  List<Widget> items = [
    Image.asset(AppImages.banner),
    Image.asset(AppImages.banner),
    Image.asset(AppImages.banner),
  ];

  // Track the current carousel index
  int _currentCarouselIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: CarouselSlider(
        items: items.asMap().entries.map((entry) {
          int index = entry.key;
          Widget item = entry.value;

          // Apply brightness/opacity based on the current index
          return AnimatedOpacity(
            opacity: _currentCarouselIndex == index
                ? 1.0
                : 0.8, // Bright for current, dim for others
            duration: Duration(milliseconds: 300), // Smooth animation
            child: item,
          );
        }).toList(),
        options: CarouselOptions(
          height: context.height * 0.32,
          aspectRatio: 16 / 9,
          viewportFraction: 0.48,
          initialPage: 1,
          enableInfiniteScroll: true, // Enable infinite scroll
          reverse: false,
          autoPlay: widget.is_autoplay, // Enable auto-play
          autoPlayInterval: Duration(seconds: 3), // Auto-play interval
          autoPlayAnimationDuration:
              Duration(milliseconds: 1200), // Smooth animation
          autoPlayCurve: Curves.fastOutSlowIn, // Animation curve
          enlargeCenterPage: true,
          enlargeFactor: 0.3,
          scrollDirection: Axis.horizontal,
          onPageChanged: (index, reason) {
            setState(() {
              _currentCarouselIndex = index; // Update the current index
            });
          },
        ),
      ),
    );
  }
}
