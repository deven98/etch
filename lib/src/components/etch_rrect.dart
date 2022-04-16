import 'package:etch/src/components/etch_element.dart';
import 'package:etch/src/components/etch_style.dart';
import 'package:flutter/material.dart';

class EtchRRect extends EtchElement {
  /// Rect to paint on the screen
  RRect? _rect;

  /// [EtchStyle] to use for painting the element
  final EtchStyle etchStyle;

  /// Rect top left in alignment terms
  Offset? _topLeftAlignment;

  /// Rect bottom right in alignment terms
  Offset? _bottomRightAlignment;

  /// Radius of the rounded corners of the Rect
  final double _radius;

  EtchRRect({
    required RRect rect,
    EtchStyle? etchStyle,
  })  : _rect = rect,
        _radius = 0.0,
        etchStyle = etchStyle ?? EtchStyle();

  EtchRRect.alignment({
    required Offset topLeftAlignment,
    required Offset bottomRightAlignment,
    double radius = 0.0,
    EtchStyle? etchStyle,
  })  : _topLeftAlignment = topLeftAlignment,
        _bottomRightAlignment = bottomRightAlignment,
        _radius = radius,
        etchStyle = etchStyle ?? EtchStyle();

  @override
  void paint(Canvas canvas, Size size) {
    if (_rect != null) {
      canvas.drawRRect(
        _rect!,
        etchStyle.paint,
      );
    }

    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromPoints(
          _getEffectiveStart(size),
          _getEffectiveEnd(size),
        ),
        Radius.circular(_radius),
      ),
      etchStyle.paint,
    );
  }

  Offset _getEffectiveStart(Size size) {
    if (_rect != null) {
      return _rect!.center - Offset(_rect!.width / 2, _rect!.height / 2);
    }

    var convUnits = _topLeftAlignment! + const Offset(1, 1);
    var effectiveOffset = size / 2;

    return Offset(convUnits.dx * effectiveOffset.width,
        convUnits.dy * effectiveOffset.height);
  }

  Offset _getEffectiveEnd(Size size) {
    if (_rect != null) {
      return _rect!.center + Offset(_rect!.width / 2, _rect!.height / 2);
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

    var e = oldElement as EtchRRect;

    return _rect != e._rect ||
        etchStyle != e.etchStyle ||
        _topLeftAlignment != e._topLeftAlignment ||
        _bottomRightAlignment != e._bottomRightAlignment;
  }
}
