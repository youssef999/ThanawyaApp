import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:thanawy2022/resources/color_manager.dart';

Widget Carsoul() {
  return CarouselSlider(
    options: CarouselOptions(height: 180.0,autoPlay: true),
    items: [
      'https://alameda.edu/wp-content/uploads/2021/07/History.png',
      'https://physicsworld.com/wp-content/uploads/2021/12/maths-and-physics-formulas-1010211756-iStock_vitacopS.jpg',
      'https://www.edarabia.com/ar/wp-content/uploads/2021/01/concept-mathematics-know-benefit-learning-it.jpg',
      'https://easyuni.com/media/articles/2020/03/30/Capture_2udiS9E.JPG',
      'https://mufahras.com/wp-content/uploads/2020/01/700.jpg',
      'https://www.edarabia.com/ar/wp-content/uploads/2020/01/importance-chemistry-lives.jpg',
      'https://www.zdnet.com/a/img/resize/4bca2f788465d943b8a1298405cf0b2246f447cd/2022/01/12/9ee89c8b-8777-49da-af0b-df23d4302b9a/physics-concept.jpg?auto=webp&fit=crop&height=900&width=1200'
    ].map((i) {
      return Builder(
        builder: (BuildContext context) {
          return Container(
              width: MediaQuery.of(context).size.width,
              margin: EdgeInsets.symmetric(horizontal: 5.0),
              decoration: BoxDecoration(color: ColorManager.primary),
              child: Image.network(
                i,
                fit: BoxFit.fill,
              ));
        },
      );
    }).toList(),
  );
}
