import 'package:flutter/material.dart';

class VioFarmaStyle {
  static TextStyle title({Color? color, bool isBold = false, double? size}) {
    return TextStyle(
        fontSize: size ?? 18, fontWeight: isBold ? FontWeight.bold : FontWeight.normal, color: color ?? Colors.black);
  }

  static TextStyle subTitle({Color? color, bool isBold = false, double? size}) {
    return TextStyle(
        fontSize: size ?? 14, fontWeight: isBold ? FontWeight.bold : FontWeight.normal, color: color ?? Colors.black);
  }
}
