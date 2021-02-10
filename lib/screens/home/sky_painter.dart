import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:prayer_times/screens/home/view/objects/sky_background.dart';
import 'package:prayer_times/screens/home/view/objects/view_object.dart';
import 'package:prayer_times/utils/colors.dart' as ColorsUtils;
import 'package:prayer_times/utils/geometry/parabolic_arc.dart';

class SkyBuilder {
  static const List<Color> skyColors = [
    Color(0xff1f253b), // start day
    Color(0xff2F333E), // fager
    Color(0xffa9bfcd), // sun rise
    Color(0xffa9bfcd), // doher
    Color(0xffa9bfcd), //  aser
    Color(0xffa9bfcd), // ma3'rb
    Color(0xff1f253b), // ashaa
    Color(0xff1f253b), // mid night
  ];

  static const List<Color> sunColors = [
    Color(0xff1f253b), // start day
    Color(0xfffae19e), // fager
    Color(0xffffffff), // sun rise
    Color(0xffffffff), // doher
    Color(0xfffae19e), // aser
    Color(0xffF8B455), //  ma3'rb
    Color(0xfffae19e), // eshaa
    Color(0xff1f253b), // mid night
  ];

  static const List<Color> sunRaysColors = [
    Color(0xff1f253b), // start day
    Color(0xfff1dcbd), // fager
    Color(0xffF8B455), // sun rise
    Color(0xffBCFFF7), // doher
    Color(0xffF8B455), // aser
    Color(0xffF875EB), // ma3'rb
    Color(0xff000000), // eshaa
    Color(0xff1f253b), // mid night
  ];

  static const List<int> prayerTimesInSeconds = [
    0, // start day
    4 * 60 * 60, // fajr
    6 * 60 * 60, // sun rise
    12 * 60 * 60, // doher
    15 * 60 * 60, // aser
    18 * 60 * 60, // ma3'rb
    20 * 60 * 60, // eshaa
    24 * 60 * 60 + 1, // mid night
  ];

  Offset calculateSunPosition(int currentTimeInSeconds, double skyWidth,
      double skyHeight, double maxSunHeight) {
    int dayLightLength = prayerTimesInSeconds[6] - prayerTimesInSeconds[1];
    double ratio =
        (currentTimeInSeconds - prayerTimesInSeconds[1]) / dayLightLength;

    double archLength = skyWidth * 2;
    ParabolicArc parabolicArc =
        new ParabolicArc(maxWidth: archLength, maxHeight: maxSunHeight);

    double x = archLength * ratio;
    double y = parabolicArc.calculate(x);
    double sunX = x - skyWidth / 2;
    double sunY = skyHeight * 0.8 - y;

    return Offset(sunX, sunY);
  }

  List<Color> getSkyColor(int currentTimeInSeconds) {
    for (int i = 0; i < prayerTimesInSeconds.length - 1; i++) {
      int j = i + 1;
      int l = prayerTimesInSeconds[i];
      int r = prayerTimesInSeconds[j];
      if (currentTimeInSeconds <= r && currentTimeInSeconds >= l) {
        double ratio = (currentTimeInSeconds - l) / (r - l);
        if (ratio > 1) ratio = 1;
        ratio = 1 - ratio;
        Color skyColor =
            ColorsUtils.Colors.mix(skyColors[i], skyColors[j], ratio);
        Color sunColor =
            ColorsUtils.Colors.mix(sunColors[i], sunColors[j], ratio);
        Color sunRaysColor =
            ColorsUtils.Colors.mix(sunRaysColors[i], sunRaysColors[j], ratio);
        return [skyColor, sunColor, sunRaysColor];
      }
    }
  }

  Widget build(double skyWidth, double skyHeight, int currentTimeInSeconds) {
    double sunSize = skyWidth * 0.1;
    double maxSunHeight = skyHeight * 0.5;
    bool isSunVisible = true;
    Offset sunPosition = Offset(0, 0);

    List<Color> list = getSkyColor(currentTimeInSeconds);
    Color skyColor = list[0];
    Color sunColor = list[1];
    Color sunRaysColor = list[2];

    // if (currentTimeInSeconds >= prayerTimesInSeconds[1] &&
    //     currentTimeInSeconds <= prayerTimesInSeconds[5]) {
    sunPosition = calculateSunPosition(
        currentTimeInSeconds, skyWidth, skyHeight, maxSunHeight);
    // } else {
    //   isSunVisible = false;
    // }
    sunSize += (sunPosition.dy / maxSunHeight) * sunSize * 3;

    List<ViewObject> viewObjects = [];
    viewObjects.add(new SkyBackground(
      Offset(0, 0),
      skyWidth,
      skyHeight,
      skyColor,
      sunColor,
      sunRaysColor,
      sunPosition,
      isSunVisible,
    ));
    //viewObjects.add(sun);
    return Sky(
      skyHeight: skyHeight,
      skyWidth: skyWidth,
      viewObjects: viewObjects,
    );
  }
}

class Sky extends StatelessWidget {
  final double skyWidth;
  final double skyHeight;
  final List<ViewObject> viewObjects;

  Sky({this.skyHeight, this.skyWidth, this.viewObjects});

  void buildSkyObjects() {}

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints.expand(
        width: skyWidth,
        height: skyHeight,
      ),
      child: CustomPaint(
        painter: SkyPainter(viewObjects: viewObjects),
      ),
    );
  }
}

class SkyPainter extends CustomPainter {
  List<ViewObject> viewObjects;
  SkyPainter({@required this.viewObjects});
  @override
  void paint(Canvas canvas, Size size) {
    viewObjects.forEach((ViewObject viewObject) {
      viewObject.draw(canvas);
    });
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    // TODO: implement shouldRepaint
    return true;
  }
}
