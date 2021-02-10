import 'dart:core';

import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:prayer_times/screens/home/view/objects/view_object.dart';

class SkyBackground extends ViewObject {
  Offset size;
  Paint paint;
  Paint sunRayPaint;
  Rect rect;
  Offset sunPosition;
  SkyBackground(Offset position, double width, double height, Color skyColor,
      Color sunColor, Color sunRaysColor, Offset sunPosition, bool isSunVisible)
      : super(
          position: position,
          width: width,
          height: height,
        ) {
    this.size = size;
    this.rect = Rect.fromLTWH(position.dx, position.dy, width, height);
    this.paint = Paint();
    this.sunRayPaint = new Paint();
    this.sunPosition = sunPosition;

    double aX = (sunPosition.dx - (width / 2)) / (width / 2);
    double aY = (sunPosition.dy - (height / 2)) / (height / 2);
    double rY = aY.abs();
    if (isSunVisible) {
      RadialGradient gradient = RadialGradient(
        center: Alignment(aX, aY), // near the top right
        radius: 0.2,
        colors: [
          sunColor,
          sunColor, // yellow sun
          skyColor, // blue sky
        ],
        stops: [
          0,
          rY,
          1,
        ],
      );
      this.paint.shader = gradient.createShader(this.rect);
      // this.paint.blendMode = BlendMode.srcOver;
      //=====================================
      sunRayPaint.shader = RadialGradient(
        center: Alignment(aX, aY),
        radius: 2,
        colors: [
          sunRaysColor,
          skyColor, // blue sky
        ],
        stops: [
          0,
          1,
        ],
      ).createShader(this.rect);
      sunRayPaint.blendMode = BlendMode.hardLight;
    } else {
      this.paint.color = skyColor;
      this.sunRayPaint.color = skyColor;
    }

    // paint.color = color;
  }

  @override
  void draw(Canvas canvas) {
    // TODO: implement draw

    canvas.drawRect(
        Rect.fromLTWH(position.dx, position.dy, width, height), paint);
    canvas.drawRect(
        Rect.fromLTWH(position.dx, position.dy, width, height), sunRayPaint);
  }
}
