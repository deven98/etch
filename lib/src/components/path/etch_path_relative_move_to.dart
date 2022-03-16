import 'package:etch/src/components/path/etch_path_element.dart';
import 'package:flutter/material.dart';

class EtchPathRelativeMoveTo extends EtchPathElement {
  Offset? _point;

  Offset? _pointAlignment;

  EtchPathRelativeMoveTo({
    required Offset point,
  }) : _point = point;

  EtchPathRelativeMoveTo.alignment({
    required Offset pointAlignment,
  }) : _pointAlignment = pointAlignment;

  Offset _getEffectiveEnd(Size size) {
    if (_point != null) {
      return _point!;
    }

    var convUnits = _pointAlignment! + const Offset(1, 1);
    var effectiveOffset = size / 2;

    return Offset(convUnits.dx * effectiveOffset.width,
        convUnits.dy * effectiveOffset.height);
  }

  @override
  void addToPath(Path path, Canvas canvas, Size size) {
    var p = _getEffectiveEnd(size);
    path.relativeMoveTo(p.dx, p.dy);
  }

  @override
  bool shouldRepaint(covariant EtchPathElement oldElement) {
    if (oldElement.runtimeType != runtimeType) {
      return true;
    }

    var e = oldElement as EtchPathRelativeMoveTo;

    return _point != e._point || _pointAlignment != e._pointAlignment;
  }
}
