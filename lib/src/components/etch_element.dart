import 'package:flutter/material.dart';

abstract class EtchElement {

  void paint(Canvas canvas, Size size);

  bool shouldRepaint(covariant EtchElement oldElement);

}
