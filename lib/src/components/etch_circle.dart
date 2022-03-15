import 'package:etch/src/components/etch_element.dart';
import 'package:etch/src/components/etch_paint.dart';
import 'package:flutter/material.dart';

class EtchCircle extends EtchElement {
  Offset? _center;
  Offset? _centerAlignment;

  final double _radius;

  final EtchPaint etchPaint;

  EtchCircle({
    required Offset center,
    required double radius,
    EtchPaint? etchPaint,
  })  : _center = center,
        _radius = radius,
        etchPaint = etchPaint ?? EtchPaint();

  EtchCircle.alignment({
    required Offset centerAlignment,
    required double radius,
    EtchPaint? etchPaint,
  })  : _centerAlignment = centerAlignment,
        _radius = radius,
        etchPaint = etchPaint ?? EtchPaint();

  Offset _getEffectiveStart(Size size) {
    if (_center != null) {
      return _center!;
    }

    var convUnits = _centerAlignment! + const Offset(1, 1);
    var effectiveOffset = size / 2;

    return Offset(convUnits.dx * effectiveOffset.width,
        convUnits.dy * effectiveOffset.height);
  }

  @override
  void paint(Canvas canvas, Size size) {
    canvas.drawCircle(
      _getEffectiveStart(size),
      _radius,
      etchPaint.paint,
    );
  }

  @override
  bool shouldRepaint(covariant EtchElement oldElement) {
    if (oldElement.runtimeType != runtimeType) {
      return true;
    }

    var e = oldElement as EtchCircle;

    return _center != e._center ||
        _radius != e._radius ||
        _centerAlignment != e._centerAlignment ||
        etchPaint != e.etchPaint;
  }
}
