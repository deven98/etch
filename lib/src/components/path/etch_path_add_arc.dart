import 'package:flutter/material.dart';

import 'etch_path_element.dart';

/// Adds an arc to the current path
class EtchPathAddArc extends EtchPathElement {
  Rect? _rect;

  Offset? _topLeftAlignment;
  Offset? _bottomRightAlignment;

  final double _startAngle;
  final double _sweepAngle;

  /// Constructor for creating the arc which uses the Rect given by the user
  EtchPathAddArc({
    required Rect rect,
    required double startAngle,
    required double sweepAngle,
  })  : _rect = rect,
        _startAngle = startAngle,
        _sweepAngle = sweepAngle;

  /// Constructor for creating the arc which uses alignments to create the Rect
  /// Alignments here are with respect to the center (Center is (0,0))
  EtchPathAddArc.alignment({
    required Offset topLeftAlignment,
    required Offset bottomRightAlignment,
    required double startAngle,
    required double sweepAngle,
  })  : _topLeftAlignment = topLeftAlignment,
        _bottomRightAlignment = bottomRightAlignment,
        _startAngle = startAngle,
        _sweepAngle = sweepAngle;

  @override
  void addToPath(Path path, Canvas canvas, Size size) {
    path.addArc(
      Rect.fromPoints(
        _getEffectiveStart(size),
        _getEffectiveEnd(size),
      ),
      _startAngle,
      _sweepAngle,
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
  bool shouldRepaint(covariant EtchPathElement oldElement) {
    if (oldElement.runtimeType != runtimeType) {
      return true;
    }

    var e = oldElement as EtchPathAddArc;

    return _rect != e._rect ||
        _topLeftAlignment != e._topLeftAlignment ||
        _bottomRightAlignment != e._bottomRightAlignment;
  }
}
