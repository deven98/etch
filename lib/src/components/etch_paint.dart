import 'package:etch/src/components/etch_element.dart';
import 'package:etch/src/components/etch_style.dart';
import 'package:flutter/material.dart';

class EtchPaint extends EtchElement {
  /// [EtchStyle] to use for painting the element
  final EtchStyle etchStyle;

  EtchPaint({
    EtchStyle? etchStyle,
  }) : etchStyle = etchStyle ?? EtchStyle();

  @override
  void paint(Canvas canvas, Size size) {
    canvas.drawPaint(etchStyle.paint);
  }

  @override
  bool shouldRepaint(covariant EtchElement oldElement) {
    if (oldElement.runtimeType != runtimeType) {
      return true;
    }

    var e = oldElement as EtchPaint;

    return etchStyle != e.etchStyle;
  }
}
