class ParabolicArc {
  double a;
  final double maxHeight;
  final double maxWidth;
  ParabolicArc({this.maxHeight, this.maxWidth}) {
    double mid = maxWidth / 2;
    a = maxHeight / (mid * mid);
  }

  double calculate(double x) {
    double sx = x - maxWidth / 2;
    return -a * (sx * sx) + maxHeight;
  }
}
