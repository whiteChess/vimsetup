import 'dart:ui';

class Colors {
  static Color mix(Color c1, Color c2, double ratio) {
    return Color.fromARGB(
      (c1.alpha * ratio + c2.alpha * (1 - ratio)).toInt(),
      (c1.red * ratio + c2.red * (1 - ratio)).toInt(),
      (c1.green * ratio + c2.green * (1 - ratio)).toInt(),
      (c1.blue * ratio + c2.blue * (1 - ratio)).toInt(),
    );
  }
}
