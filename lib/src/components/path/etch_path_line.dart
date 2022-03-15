import 'package:etch/src/components/path/etch_path_element.dart';
import 'package:flutter/material.dart';

import '../etch_paint.dart';

class EtchPathLine extends EtchPathElement {
  Offset? _point;

  Offset? _pointAlignment;

  EtchPathLine({
    required Offset point,
    EtchPaint? etchPaint,
  }) : _point = point;

  EtchPathLine.alignment({
    required Offset pointAlignment,
    EtchPaint? etchPaint,
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
    path.lineTo(p.dx, p.dy);
  }

  @override
  bool shouldRepaint(covariant EtchPathElement oldElement) {
    if (oldElement.runtimeType != runtimeType) {
      return true;
    }

    var e = oldElement as EtchPathLine;

    return _point != e._point || _pointAlignment != e._pointAlignment;
  }
}
