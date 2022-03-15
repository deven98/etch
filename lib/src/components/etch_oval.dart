import 'package:etch/src/components/etch_element.dart';
import 'package:etch/src/components/etch_paint.dart';
import 'package:flutter/material.dart';

class EtchOval extends EtchElement {
  Rect? _rect;

  final EtchPaint etchPaint;

  Offset? _topLeftAlignment;
  Offset? _bottomRightAlignment;

  EtchOval({
    required Rect rect,
    EtchPaint? etchPaint,
  })  : _rect = rect,
        etchPaint = etchPaint ?? EtchPaint();

  EtchOval.alignment({
    required Offset topLeftAlignment,
    required Offset bottomRightAlignment,
    EtchPaint? etchPaint,
  })  : _topLeftAlignment = topLeftAlignment,
        _bottomRightAlignment = bottomRightAlignment,
        etchPaint = etchPaint ?? EtchPaint();

  @override
  void paint(Canvas canvas, Size size) {
    canvas.drawOval(
      Rect.fromPoints(
        _getEffectiveStart(size),
        _getEffectiveEnd(size),
      ),
      etchPaint.paint,
    );
  }

  Offset _getEffectiveStart(Size size) {
    if (_rect != null) {
      return _rect!.topLeft;
    }

    var convUnits = _topLeftAlignment! + const Offset(1, 1);
    var effectiveOffset = size / 2;

    return Offset(convUnits.dx * effectiveOffset.width,
        convUnits.dy * effectiveOffset.height);
  }

  Offset _getEffectiveEnd(Size size) {
    if (_rect != null) {
      return _rect!.bottomRight;
    }

    var convUnits = _bottomRightAlignment! + const Offset(1, 1);
    var effectiveOffset = size / 2;

    return Offset(convUnits.dx * effectiveOffset.width,
        convUnits.dy * effectiveOffset.height);
  }

  @override
  bool shouldRepaint(covariant EtchElement oldElement) {
    if (oldElement.runtimeType != runtimeType) {
      return true;
    }

    var e = oldElement as EtchOval;

    return _rect != e._rect ||
        etchPaint != e.etchPaint ||
        _topLeftAlignment != e._topLeftAlignment ||
        _bottomRightAlignment != e._bottomRightAlignment;
  }
}
