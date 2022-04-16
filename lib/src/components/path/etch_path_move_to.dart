import 'package:etch/src/components/path/etch_path_element.dart';
import 'package:flutter/material.dart';

import '../etch_style.dart';

/// Move the current point of the path elsewhere
class EtchPathMoveTo extends EtchPathElement {
  Offset? _point;

  Offset? _pointAlignment;

  EtchPathMoveTo({
    required Offset point,
    EtchStyle? etchPaint,
  }) : _point = point;

  EtchPathMoveTo.alignment({
    required Offset pointAlignment,
    EtchStyle? etchPaint,
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
    path.moveTo(p.dx, p.dy);
  }

  @override
  bool shouldRepaint(covariant EtchPathElement oldElement) {
    if (oldElement.runtimeType != runtimeType) {
      return true;
    }

    var e = oldElement as EtchPathMoveTo;

    return _point != e._point || _pointAlignment != e._pointAlignment;
  }
}
