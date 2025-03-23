import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:s7_front/main_screens/landmarks/landmark_card.dart';

import '../../api/back_flight.swagger.dart';

class LandmarkList extends StatelessWidget {
  final List<Poi> landmarks;
  final Function? onTap;

  const LandmarkList({super.key, required this.landmarks, this.onTap});

  @override
  Widget build(BuildContext context) {
    return CarouselSlider.builder(
      itemCount: landmarks.length,
      itemBuilder: (context, index, realIndex) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: LandmarkCard(landmark: landmarks[index], onTap: onTap != null ? () => onTap!(landmarks[index]) : null),
        );
      },
      options: CarouselOptions(
        enlargeCenterPage: true, // Увеличение центральной карточки
        aspectRatio: 0.55, // Пропорции для карточек
        viewportFraction: 1, // Размер каждого элемента относительно экрана
        scrollPhysics: BouncingScrollPhysics(), // Эффект пружины
      ),
    );
  }
}
