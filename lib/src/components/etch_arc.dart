import 'package:etch/src/components/etch_element.dart';
import 'package:etch/src/components/etch_paint.dart';
import 'package:flutter/material.dart';

class EtchArc extends EtchElement {
  Rect? _rect;

  final EtchPaint etchPaint;

  Offset? _topLeftAlignment;
  Offset? _bottomRightAlignment;

  final double _startAngle;
  final double _sweepAngle;
  final bool _useCenter;

  EtchArc({
    required Rect rect,
    required double startAngle,
    required double sweepAngle,
    bool useCenter = true,
    EtchPaint? etchPaint,
  })  : _rect = rect,
        _startAngle = startAngle,
        _sweepAngle = sweepAngle,
        _useCenter = useCenter,
        etchPaint = etchPaint ?? EtchPaint();

  EtchArc.alignment({
    required Offset topLeftAlignment,
    required Offset bottomRightAlignment,
    required double startAngle,
    required double sweepAngle,
    bool useCenter = true,
    EtchPaint? etchPaint,
  })  : _topLeftAlignment = topLeftAlignment,
        _bottomRightAlignment = bottomRightAlignment,
        _startAngle = startAngle,
        _sweepAngle = sweepAngle,
        _useCenter = useCenter,
        etchPaint = etchPaint ?? EtchPaint();

  @override
  void paint(Canvas canvas, Size size) {
    canvas.drawArc(
      Rect.fromPoints(
        _getEffectiveStart(size),
        _getEffectiveEnd(size),
      ),
      _startAngle,
      _sweepAngle,
      _useCenter,
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

    var e = oldElement as EtchArc;

    return _rect != e._rect ||
        etchPaint != e.etchPaint ||
        _topLeftAlignment != e._topLeftAlignment ||
        _bottomRightAlignment != e._bottomRightAlignment;
  }
}
