import 'package:flutter/material.dart';
import 'package:liquid_swipe/liquid_swipe.dart';
import 'package:new_spark/config/palette.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class MyCV extends StatefulWidget {
  const MyCV({super.key});

  @override
  State<MyCV> createState() => _MyCVState();
}

class _MyCVState extends State<MyCV> {
  final controller = LiquidController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          LiquidSwipe(
              liquidController: controller,
              enableSideReveal: true,
              onPageChangeCallback: (index) {
                setState(() {});
              },
              slideIconWidget: const Icon(
                Icons.arrow_back_ios,
                color: Colors.white,
              ),
              pages: [
                Container(
                    color: Colors.black,
                    child: const Center(
                      child: Text(
                        'Page 1',
                        style: TextStyle(
                            fontSize: 40.0,
                            color: Colors.white,
                            fontWeight: FontWeight.bold),
                      ),
                    )),
                Container(
                    color: Colors.amber,
                    child: const Center(
                      child: Text('Page 2',
                          style: TextStyle(
                              fontSize: 40.0,
                              color: Colors.white,
                              fontWeight: FontWeight.bold)),
                    )),
                Container(
                    color: Colors.blue,
                    child: const Center(
                      child: Text('Page 3',
                          style: TextStyle(
                              fontSize: 40.0,
                              color: Colors.white,
                              fontWeight: FontWeight.bold)),
                    )),
                Container(
                    color: Colors.green,
                    child: const Center(
                      child: Text('Page 4',
                          style: TextStyle(
                              fontSize: 40.0,
                              color: Colors.white,
                              fontWeight: FontWeight.bold)),
                    ))
              ]),
          Positioned(
            bottom: 0,
            left: 16,
            right: 32,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton(
                    onPressed: () {
                      controller.jumpToPage(page: 3);
                    },
                    child: Text('SKIP')),
                AnimatedSmoothIndicator(
                  activeIndex: controller.currentPage,
                  count: 4,
                  effect: const WormEffect(
                      spacing: 16,
                      dotColor: Colors.white54,
                      activeDotColor: Colors.white),
                  onDotClicked: (index) {
                    controller.animateToPage(page: index);
                  },
                ),
                TextButton(
                    onPressed: () {
                      final page = controller.currentPage + 1;
                      controller.animateToPage(
                          page: page > 4 ? 0 : page, duration: 400);
                    },
                    child: Text('NEXT')),
              ],
            ),
          )
        ],
      ),
    );
  }
}
