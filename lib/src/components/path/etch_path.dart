import 'package:etch/etch.dart';
import 'package:flutter/material.dart';

/// Draws a path using [EtchPathElement]s
class EtchPath extends EtchElement {
  /// A list of path elements to draw on the screen
  final List<EtchPathElement> etchPathElements;

  /// [EtchStyle] to use for painting the path elements
  final EtchStyle _etchStyle;

  EtchPath({
    required this.etchPathElements,
    EtchStyle? etchStyle,
  }) : _etchStyle = etchStyle ?? EtchStyle();

  @override
  void paint(Canvas canvas, Size size) {
    Path path = Path();

    for (var e in etchPathElements) {
      e.addToPath(path, canvas, size);
    }

    canvas.drawPath(path, _etchStyle.paint);
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
