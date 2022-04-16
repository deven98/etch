import 'package:flutter/material.dart';

/// Abstract class for creating your own [EtchElement] to add to the canvas
abstract class EtchElement {
  void paint(Canvas canvas, Size size);

  bool shouldRepaint(covariant EtchElement oldElement);
}
