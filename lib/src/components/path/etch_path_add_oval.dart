import 'package:flutter/material.dart';

import 'etch_path_element.dart';

/// Adds an oval to the current path
class EtchPathAddOval extends EtchPathElement {
  Rect? _rect;

  Offset? _topLeftAlignment;
  Offset? _bottomRightAlignment;

  /// Constructor for creating the oval which uses the Rect given by the user
  EtchPathAddOval({
    required Rect rect,
  }) : _rect = rect;

  /// Constructor for creating the oval which uses alignments to create the Rect
  /// Alignments here are with respect to the center (Center is (0,0))
  EtchPathAddOval.alignment({
    required Offset topLeftAlignment,
    required Offset bottomRightAlignment,
  })  : _topLeftAlignment = topLeftAlignment,
        _bottomRightAlignment = bottomRightAlignment;

  @override
  void addToPath(Path path, Canvas canvas, Size size) {
    path.addOval(
      Rect.fromPoints(
        _getEffectiveStart(size),
        _getEffectiveEnd(size),
      ),
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

    var e = oldElement as EtchPathAddOval;

    return _rect != e._rect ||
        _topLeftAlignment != e._topLeftAlignment ||
        _bottomRightAlignment != e._bottomRightAlignment;
  }
}
