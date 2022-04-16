import 'package:flutter/material.dart';

import 'etch_path_element.dart';

/// Add a conic bezier curve from the current point to the offset given
/// Relative paths are drawn with respect to the current point, not the origin
/// The alignment constructor effectively uses the current point as origin and
/// calculates alignment using the bounding size
class EtchPathRelativeConicTo extends EtchPathElement {
  Offset? _controlPoint;
  Offset? _endPoint;

  Offset? _controlPointAlignment;
  Offset? _endPointAlignment;

  final double _weight;

  EtchPathRelativeConicTo({
    required Offset controlPoint,
    required Offset endPoint,
    double weight = 1,
  })  : _controlPoint = controlPoint,
        _endPoint = endPoint,
        _weight = weight;

  EtchPathRelativeConicTo.alignment({
    required Offset controlPointAlignment,
    required Offset endPointAlignment,
    double weight = 1,
  })  : _controlPointAlignment = controlPointAlignment,
        _endPointAlignment = endPointAlignment,
        _weight = weight;

  Offset _getEffectiveStart(Size size) {
    if (_controlPoint != null) {
      return _controlPoint!;
    }

    var convUnits = _controlPointAlignment! + const Offset(1, 1);
    var effectiveOffset = size / 2;

    return Offset(convUnits.dx * effectiveOffset.width,
        convUnits.dy * effectiveOffset.height);
  }

  Offset _getEffectiveEnd(Size size) {
    if (_endPoint != null) {
      return _endPoint!;
    }

    var convUnits = _endPointAlignment! + const Offset(1, 1);
    var effectiveOffset = size / 2;

    return Offset(convUnits.dx * effectiveOffset.width,
        convUnits.dy * effectiveOffset.height);
  }

  @override
  void addToPath(Path path, Canvas canvas, Size size) {
    var effectiveControlPoint = _getEffectiveStart(size);
    var effectiveEndpoint = _getEffectiveEnd(size);
    path.relativeConicTo(
      effectiveControlPoint.dx,
      effectiveControlPoint.dy,
      effectiveEndpoint.dx,
      effectiveEndpoint.dy,
      _weight,
    );
  }

  @override
  bool shouldRepaint(covariant EtchPathElement oldElement) {
    if (oldElement.runtimeType != runtimeType) {
      return true;
    }

    var e = oldElement as EtchPathRelativeConicTo;

    return _endPoint != e._endPoint ||
        _controlPoint != e._controlPoint ||
        _weight != e._weight ||
        _controlPointAlignment != e._controlPointAlignment ||
        _endPointAlignment != e._endPointAlignment;
  }
}
