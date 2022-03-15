import 'package:etch/etch.dart';
import 'package:etch/src/components/path/etch_path_element.dart';
import 'package:flutter/material.dart';

class EtchPath extends EtchElement {
  final List<EtchPathElement> etchPathElements;
  final EtchPaint _etchPaint;

  EtchPath({
    required this.etchPathElements,
    EtchPaint? etchPaint,
  }) : _etchPaint = etchPaint ?? EtchPaint();

  @override
  void paint(Canvas canvas, Size size) {
    Path path = Path();

    for (var e in etchPathElements) {
      e.addToPath(path, canvas, size);
    }

    canvas.drawPath(path, _etchPaint.paint);
  }

  @override
  bool shouldRepaint(covariant EtchElement oldElement) {
    if (oldElement.runtimeType != runtimeType) {
      return true;
    }

    var e = oldElement as EtchPath;

    if (e.etchPathElements.length != etchPathElements.length) {
      return true;
    }

    for (int i = 0; i < etchPathElements.length; i++) {
      if (etchPathElements[i].shouldRepaint(e.etchPathElements[i])) {
        return true;
      }
    }

    return false;
  }
}
