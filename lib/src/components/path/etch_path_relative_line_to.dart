import 'package:etch/src/components/path/etch_path_element.dart';
import 'package:flutter/material.dart';

/// Add a line to the path
/// Relative paths are drawn with respect to the current point, not the origin
/// The alignment constructor effectively uses the current point as origin and
/// calculates alignment using the bounding size
class EtchPathRelativeLineTo extends EtchPathElement {
  Offset? _point;

  Offset? _pointAlignment;

  EtchPathRelativeLineTo({
    required Offset point,
  }) : _point = point;

  EtchPathRelativeLineTo.alignment({
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
    path.relativeLineTo(p.dx, p.dy);
  }

  @override
  bool shouldRepaint(covariant EtchPathElement oldElement) {
    if (oldElement.runtimeType != runtimeType) {
      return true;
    }

    var e = oldElement as EtchPathRelativeLineTo;

    return _point != e._point || _pointAlignment != e._pointAlignment;
  }
}
