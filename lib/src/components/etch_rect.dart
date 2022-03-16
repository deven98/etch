import 'package:etch/src/components/etch_element.dart';
import 'package:etch/src/components/etch_style.dart';
import 'package:flutter/material.dart';

class EtchRect extends EtchElement {
  Rect? _rect;

  final EtchStyle etchStyle;

  Offset? _topLeftAlignment;
  Offset? _bottomRightAlignment;

  EtchRect({
    required Rect rect,
    EtchStyle? etchStyle,
  })  : _rect = rect,
        etchStyle = etchStyle ?? EtchStyle();

  EtchRect.alignment({
    required Offset topLeftAlignment,
    required Offset bottomRightAlignment,
    EtchStyle? etchStyle,
  })  : _topLeftAlignment = topLeftAlignment,
        _bottomRightAlignment = bottomRightAlignment,
        etchStyle = etchStyle ?? EtchStyle();

  @override
  void paint(Canvas canvas, Size size) {
    canvas.drawRect(
      Rect.fromPoints(
        _getEffectiveStart(size),
        _getEffectiveEnd(size),
      ),
      etchStyle.paint,
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

    var e = oldElement as EtchRect;

    return _rect != e._rect ||
        etchStyle != e.etchStyle ||
        _topLeftAlignment != e._topLeftAlignment ||
        _bottomRightAlignment != e._bottomRightAlignment;
  }
}
