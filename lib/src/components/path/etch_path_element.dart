import 'package:flutter/material.dart';

abstract class EtchPathElement {
  void addToPath(Path path, Canvas canvas, Size size);

  bool shouldRepaint(covariant EtchPathElement oldElement);
}
