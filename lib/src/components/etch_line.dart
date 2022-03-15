import 'package:etch/src/components/etch_element.dart';
import 'package:flutter/material.dart';

class EtchLine extends EtchElement {
  final Offset a;
  final Offset b;
  final Paint p;

  EtchLine(this.a, this.b, this.p);

  @override
  void paint(Canvas canvas, Size size) {
    canvas.drawLine(a, b, p);
  }

  @override
  bool shouldRepaint(covariant EtchElement oldElement) {
    if(oldElement.runtimeType != runtimeType) {
      return true;
    }

    var e = oldElement as EtchLine;

    return a != e.a || b != e.b;
  }


}