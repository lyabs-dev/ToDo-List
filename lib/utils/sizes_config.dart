import 'package:flutter/material.dart';

class SizeConfig extends StatelessWidget {
  final Widget mobile;
  final Widget? tablet;
  final Widget desktop;

  const SizeConfig({
    Key? key,
    required this.mobile,
    this.tablet,
    required this.desktop,
  }) : super(key: key);


  static bool isMobile(BuildContext context) =>
      MediaQuery.of(context).size.width < 850;

  static bool isTablet(BuildContext context) =>
      MediaQuery.of(context).size.width < 1100 && MediaQuery.of(context).size.width >= 850;

  static bool isDesktop(BuildContext context) =>
      MediaQuery.of(context).size.width >= 1100;

  @override
  Widget build(BuildContext context) {
    final Size _size = MediaQuery.of(context).size;
    if (_size.width >= 1100) {
      return desktop;
    }
    else if (_size.width >= 850 && tablet != null) {
      return tablet!;
    }
    else {
      return mobile;
    }
  }
}


// Get the proportionate height as per screen size
double getProportionateScreenHeight(double inputHeight,BuildContext context ) {
  double screenHeight = MediaQuery.of(context).size.height;
  // 812 is the layout height that designer use
  return (inputHeight / 812.0) * screenHeight;
}

// Get the proportionate height as per screen size
double getProportionateScreenWidth(double inputWidth,BuildContext context) {
  double screenWidth =MediaQuery.of(context).size.width;
  // 375 is the layout width that designer use
  return (inputWidth / 375.0) * screenWidth;
}

// Get the proportionate side as per screen short size
double getShortSize(double inputSide, BuildContext context) {
  double screenShortSide = MediaQuery.of(context).size.shortestSide;
  // 375 is the layout width that designer use
  return (inputSide / 375.0) * screenShortSide;
}
