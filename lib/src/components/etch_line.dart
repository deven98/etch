import 'package:etch/src/components/etch_element.dart';
import 'package:etch/src/components/etch_paint.dart';
import 'package:flutter/material.dart';

class EtchLine extends EtchElement {
  Offset? _start;
  Offset? _end;

  final EtchPaint etchPaint;

  Offset? _startAlignment;
  Offset? _endAlignment;

  EtchLine({
    required Offset start,
    required Offset end,
    EtchPaint? etchPaint,
  })  : _start = start,
        _end = end,
        etchPaint = etchPaint ?? EtchPaint();

  EtchLine.alignment({
    required Offset startAlignment,
    required Offset endAlignment,
    EtchPaint? etchPaint,
  })  : _startAlignment = startAlignment,
        _endAlignment = endAlignment,
        etchPaint = etchPaint ?? EtchPaint();

  Offset _getEffectiveStart(Size size) {
    if (_start != null) {
      return _start!;
    }

    var convUnits = _startAlignment! + const Offset(1, 1);
    var effectiveOffset = size / 2;

    return Offset(convUnits.dx * effectiveOffset.width,
        convUnits.dy * effectiveOffset.height);
  }

  Offset _getEffectiveEnd(Size size) {
    if (_end != null) {
      return _end!;
    }

    var convUnits = _endAlignment! + const Offset(1, 1);
    var effectiveOffset = size / 2;

    return Offset(convUnits.dx * effectiveOffset.width,
        convUnits.dy * effectiveOffset.height);
  }

  @override
  void paint(Canvas canvas, Size size) {
    canvas.drawLine(
        _getEffectiveStart(size), _getEffectiveEnd(size), etchPaint.paint);
  }

  @override
  bool shouldRepaint(covariant EtchElement oldElement) {
    if (oldElement.runtimeType != runtimeType) {
      return true;
    }

    var e = oldElement as EtchLine;

    return _start != e._start ||
        _end != e._end ||
        _startAlignment != e._startAlignment ||
        _endAlignment != e._endAlignment;
  }
}
