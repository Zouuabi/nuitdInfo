import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:liquid_swipe/liquid_swipe.dart';
import 'package:mouvema/src/core/utils/color_manager.dart';

///Class to hold data for itembuilder in Withbuilder app.

import '../../../../config/routes/routes.dart';

class ItemData {
  final Color color;
  final String image;
  final String text1;

  ItemData(
    this.color,
    this.image,
    this.text1,
  );
}

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({super.key});

  @override
  State<OnBoardingScreen> createState() => OnBoardingScreenState();
}

class OnBoardingScreenState extends State<OnBoardingScreen> {
  int page = 0;
  late LiquidController liquidController;
  late UpdateType updateType;

  List<ItemData> data = [
    ItemData(
      Colors.teal,
      "assets/images/carousel1.jpg",
      "The best app for shipping & delivery in this century",
    ),
    ItemData(
      Colors.teal,
      "assets/images/carousel2.jpg",
      "Wassa3 Wassa3 mouvema jet",
    ),
    ItemData(
      Colors.teal,
      "assets/images/carousel3.jpg",
      "ahla b nahla odkhel ay ",
    ),
  ];

  @override
  void initState() {
    liquidController = LiquidController();
    super.initState();
  }

  Widget _buildDot(int index) {
    double selectedness = Curves.easeOut.transform(
      max(
        0.0,
        1.0 - ((page) - index).abs(),
      ),
    );
    double zoom = 1.0 + (2.0 - 1.0) * selectedness;
    return SizedBox(
      width: 25.0,
      child: Center(
        child: Material(
          color: ColorManager.mouvemaTeal,
          type: MaterialType.circle,
          child: SizedBox(
            width: 8.0 * zoom,
            height: 8.0 * zoom,
          ),
        ),
      ),
    );
  }

  void toLogin() async {
    Timer(const Duration(seconds: 1), () {
      Navigator.pushReplacementNamed(context, Routes.login);
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          LiquidSwipe.builder(
            itemCount: data.length,
            itemBuilder: (context, index) {
              return SizedBox(
                width: double.infinity,
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                    Image.asset(
                      data[index].image,
                      fit: BoxFit.fill,
                    ),
                  ],
                ),
              );
            },
            positionSlideIcon: 0.6,
            slideIconWidget: const Icon(
              Icons.arrow_back_ios,
              color: ColorManager.mouvemaWhite,
            ),
            onPageChangeCallback: pageChangeCallback,
            waveType: WaveType.liquidReveal,
            liquidController: liquidController,
            fullTransitionValue: 880,
            enableSideReveal: true,
            preferDragFromRevealedArea: true,
            enableLoop: true,
            ignoreUserGestureWhileAnimating: true,
          ),
          Positioned(
            bottom: 50,
            right: 0,
            left: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List<Widget>.generate(data.length, _buildDot),
            ),
          ),
          Positioned(
              bottom: 120,
              right: 20,
              left: 20,
              child: Center(
                child: Text(
                  data[page].text1,
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.displaySmall,
                ),
              )),
          Align(
            alignment: Alignment.bottomRight,
            child: Padding(
              padding: const EdgeInsets.all(25.0),
              child: TextButton(
                onPressed: () {
                  liquidController.animateToPage(
                      page: data.length - 1, duration: 700);
                },
                child: const Text("Skip to End"),
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomLeft,
            child: Padding(
              padding: const EdgeInsets.all(25.0),
              child: TextButton(
                onPressed: () {
                  liquidController.jumpToPage(
                      page: liquidController.currentPage + 1 > data.length - 1
                          ? 0
                          : liquidController.currentPage + 1);
                },
                child: const Text("Next"),
              ),
            ),
          )
        ],
      ),
    );
  }

  pageChangeCallback(int lpage) {
    setState(() {
      page = lpage;
    });
    if (page == 2) {
      toLogin();
    }
  }
}
