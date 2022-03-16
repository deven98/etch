import 'package:flutter/material.dart';

import 'etch_path_element.dart';

class EtchPathCubicTo extends EtchPathElement {
  Offset? _controlPoint;
  Offset? _controlPoint2;
  Offset? _endPoint;

  Offset? _controlPointAlignment;
  Offset? _controlPoint2Alignment;
  Offset? _endPointAlignment;

  EtchPathCubicTo({
    required Offset controlPoint,
    required Offset controlPoint2,
    required Offset endPoint,
  })  : _controlPoint = controlPoint,
        _controlPoint2 = controlPoint2,
        _endPoint = endPoint;

  EtchPathCubicTo.alignment({
    required Offset controlPointAlignment,
    required Offset controlPoint2Alignment,
    required Offset endPointAlignment,
  })  : _controlPointAlignment = controlPointAlignment,
        _controlPoint2Alignment = controlPoint2Alignment,
        _endPointAlignment = endPointAlignment;

  Offset _getEffectiveStart(Size size) {
    if (_controlPoint != null) {
      return _controlPoint!;
    }

    var convUnits = _controlPointAlignment! + const Offset(1, 1);
    var effectiveOffset = size / 2;

    return Offset(convUnits.dx * effectiveOffset.width,
        convUnits.dy * effectiveOffset.height);
  }

  Offset _getEffectiveMid(Size size) {
    if (_controlPoint2 != null) {
      return _controlPoint2!;
    }

    var convUnits = _controlPoint2Alignment! + const Offset(1, 1);
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
    var effectiveControlPoint2 = _getEffectiveMid(size);
    var effectiveEndpoint = _getEffectiveEnd(size);
    path.cubicTo(
      effectiveControlPoint.dx,
      effectiveControlPoint.dy,
      effectiveControlPoint2.dx,
      effectiveControlPoint2.dy,
      effectiveEndpoint.dx,
      effectiveEndpoint.dy,
    );
  }

  @override
  bool shouldRepaint(covariant EtchPathElement oldElement) {
    if (oldElement.runtimeType != runtimeType) {
      return true;
    }

    var e = oldElement as EtchPathCubicTo;

    return _endPoint != e._endPoint ||
        _controlPoint != e._controlPoint ||
        _controlPoint2 != e._controlPoint2 ||
        _controlPointAlignment != e._controlPointAlignment ||
        _controlPoint2Alignment != e._controlPoint2Alignment ||
        _endPointAlignment != e._endPointAlignment;
  }
}
