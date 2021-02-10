import 'dart:ui' as ui;

import 'package:flutter/painting.dart';
import 'package:prayer_times/assets_cache.dart';
import 'package:prayer_times/screens/home/view/objects/view_object.dart';

class Sun extends ViewObject {
  Offset size;
  ui.Image image;
  Color color;
  Sun(Offset position, double width, double height, Color color)
      : super(position: position, width: width, height: height) {
    this.size = size;
    this.image = AssetsCache.getImage("sun.png");
    this.color = color;
  }

  @override
  void draw(Canvas canvas) {
    // TODO: implement draw
    paintImage(
        canvas: canvas,
        image: image,
        rect: Rect.fromCenter(
          center: position,
          width: width,
          height: height,
        ));
  }
}
