import 'package:flutter/material.dart';

/// Abstract class for creating your own [EtchPathElement] to add to the path
abstract class EtchPathElement {
  /// Modify the path to your requirement here
  void addToPath(Path path, Canvas canvas, Size size);

  /// Define in what conditions the path should be repainted
  bool shouldRepaint(covariant EtchPathElement oldElement);
}
