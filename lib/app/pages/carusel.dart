import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

class Carusel extends StatelessWidget {
  Carusel({super.key});

  final List<String> books = [
    'asset/images/car.avif',
    'asset/images/library.avif',
    'asset/images/chil.avif',
    'asset/images/ooo.avif',
    'asset/images/read.avif',
    'asset/images/nature.avif',
    'asset/images/women.avif',
  ];

  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      options: CarouselOptions(
        autoPlayInterval: const Duration(seconds: 3),
        autoPlay: true,
        height: 200.0,
        enlargeCenterPage: true,
        viewportFraction: 0.85, 
        autoPlayAnimationDuration: const Duration(milliseconds: 800),
        autoPlayCurve: Curves.fastOutSlowIn, 
      ),
      items: books.map((i) {
        return Builder(
          builder: (BuildContext context) {
            return Container(
              width: MediaQuery.of(context).size.width,
              margin: const EdgeInsets.symmetric(horizontal: 5.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 10,
                    spreadRadius: 2,
                    offset: Offset(0, 4),
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    Image.asset(
                      i,
                      fit: BoxFit.cover,
                    ),
                 
                  ],
                ),
              ),
            );
          },
        );
      }).toList(),
    );
  }
}
