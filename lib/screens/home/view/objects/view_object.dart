import 'dart:ui';

abstract class ViewObject {
  Offset position;
  double width;
  double height;
  bool visible;
  ViewObject({this.position, this.width, this.height, this.visible});

  void draw(Canvas canvas);
  void update;
}
