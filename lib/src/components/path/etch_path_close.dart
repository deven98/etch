import 'package:etch/src/components/path/etch_path_element.dart';
import 'package:flutter/material.dart';

class EtchPathClose extends EtchPathElement {
  @override
  void addToPath(Path path, Canvas canvas, Size size) {
    path.close();
  }

  @override
  bool shouldRepaint(covariant EtchPathElement oldElement) {
    if (oldElement.runtimeType != runtimeType) {
      return true;
    }

    return false;
  }
}
