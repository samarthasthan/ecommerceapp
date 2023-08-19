import 'dart:async';

import 'package:ecommerceapp/constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OnBoardConller extends GetxController {
  Rx<Color> backGroundColor = onBoardColor1.obs;
  Rx<String> qoute = "Find the hottest\ndeal.".obs;
  Rx<String> imageUrl =
      "https://assets.vogue.in/photos/5d288836e2f0130008fa5d30/1:1/w_1080,h_1080,c_limit/model%20nidhi%20sunil.jpg"
          .obs;
  List<Color> colors = [
    onBoardColor1,
    onBoardColor2,
    onBoardColor3,
    onBoardColor4,
  ];
  List<String> images = [
    "https://assets.vogue.in/photos/5d288836e2f0130008fa5d30/1:1/w_1080,h_1080,c_limit/model%20nidhi%20sunil.jpg",
    "https://www.visionmodels.co.uk/images/women.jpg",
    "https://weproject.media/upload/medialibrary/bc4/bc46df8a6746b1f0c0d3e14983055646.jpeg",
    "https://i.pinimg.com/474x/06/fd/94/06fd94c3eb769088904f45f4ae7e8cf8.jpg",
  ];

  List<String> quotes = [
    "Find the hottest\ndeal.",
    "Comapare prices from\nyour favrite stores",
    "Shop the internet\nShop with FruBay.",
    "Quick and easy\nShop.",
  ];
  Timer? colorTimer;

  void startBackgroundColorChange() {
    var x = 0;
    const period = Duration(seconds: 3);
    colorTimer?.cancel(); // Cancel any previous timers
    colorTimer = Timer.periodic(period, (timer) {
      if (x == 3) {
        x = 0;
      } else {
        x++;
      }
      imageUrl.value = images[x];
      qoute.value = quotes[x];
      backGroundColor.value = colors[x];
    });
  }

  @override
  void onClose() {
    colorTimer?.cancel(); // Cancel the timer when the controller is closed
    super.onClose();
  }
}
