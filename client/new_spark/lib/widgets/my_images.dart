import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

import '../screens/screens.dart';

class MyImages extends StatelessWidget {
  const MyImages({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10.0),
      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(10.0)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'My Images',
            style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
                color: Colors.black45),
          ),
          const SizedBox(
            height: 10.0,
          ),
          CarouselSlider.builder(
              //itemCount: stories.length,
              itemCount: 5,
              itemBuilder: (context, index, realIndex) {
                final urlImage =
                    "https://www.grouphealth.ca/wp-content/uploads/2018/05/placeholder-image.png";

//                final urlImage = stories[index].imageUrl;
                return _buildImage(urlImage, index);
              },
              options: CarouselOptions(
                  height: 300, autoPlay: true, enlargeCenterPage: true)),
          TextButton(
              onPressed: () {
                Navigator.push(
                    context, MaterialPageRoute(builder: (_) => Gallery()));
              },
              child: Container(
                  padding: const EdgeInsets.symmetric(
                      vertical: 10.0, horizontal: 20.0),
                  decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(20.0)),
                  child: Text(
                    'See More',
                    style: TextStyle(color: Colors.orange[700]),
                  )))
        ],
      ),
    );
  }
}

Widget _buildImage(String urlImage, int index) => Container(
      color: Colors.grey,
      child: CachedNetworkImage(
        imageUrl: urlImage,
        fit: BoxFit.fill,
      ),
    );
