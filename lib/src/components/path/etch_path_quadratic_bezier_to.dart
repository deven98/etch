import 'package:flutter/material.dart';

import 'etch_path_element.dart';

/// Draw a quadratic bezier the end point using the control point
class EtchPathQuadraticBezierTo extends EtchPathElement {
  Offset? _controlPoint;
  Offset? _endPoint;

  Offset? _controlPointAlignment;
  Offset? _endPointAlignment;

  EtchPathQuadraticBezierTo({
    required Offset controlPoint,
    required Offset endPoint,
  })  : _controlPoint = controlPoint,
        _endPoint = endPoint;

  EtchPathQuadraticBezierTo.alignment({
    required Offset controlPointAlignment,
    required Offset endPointAlignment,
  })  : _controlPointAlignment = controlPointAlignment,
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
    path.quadraticBezierTo(
      effectiveControlPoint.dx,
      effectiveControlPoint.dy,
      effectiveEndpoint.dx,
      effectiveEndpoint.dy,
    );
  }

  @override
  bool shouldRepaint(covariant EtchPathElement oldElement) {
    if (oldElement.runtimeType != runtimeType) {
      return true;
    }

    var e = oldElement as EtchPathQuadraticBezierTo;

    return _endPoint != e._endPoint ||
        _controlPoint != e._controlPoint ||
        _controlPointAlignment != e._controlPointAlignment ||
        _endPointAlignment != e._endPointAlignment;
  }
}
