import 'package:etch/src/components/etch_element.dart';
import 'package:etch/src/components/etch_style.dart';
import 'package:flutter/material.dart';

/// Draws a line on the canvas
class EtchLine extends EtchElement {
  /// Start of the line in pixel terms
  Offset? _start;

  /// End of the line in pixel terms
  Offset? _end;

  /// [EtchStyle] to use for painting the element
  final EtchStyle etchStyle;

  /// Start of the line in alignment terms
  Offset? _startAlignment;

  /// End of the line in alignment terms
  Offset? _endAlignment;

  EtchLine({
    required Offset start,
    required Offset end,
    EtchStyle? etchStyle,
  })  : _start = start,
        _end = end,
        etchStyle = etchStyle ?? EtchStyle();

  EtchLine.alignment({
    required Offset startAlignment,
    required Offset endAlignment,
    EtchStyle? etchStyle,
  })  : _startAlignment = startAlignment,
        _endAlignment = endAlignment,
        etchStyle = etchStyle ?? EtchStyle();

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
        _getEffectiveStart(size), _getEffectiveEnd(size), etchStyle.paint);
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
        etchStyle != e.etchStyle ||
        _endAlignment != e._endAlignment;
  }
}
