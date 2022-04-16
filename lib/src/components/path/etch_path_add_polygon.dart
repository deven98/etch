import 'package:etch/src/components/path/etch_path_element.dart';
import 'package:flutter/material.dart';

/// Adds a polygon to the current path
class EtchPathAddPolygon extends EtchPathElement {
  List<Offset>? _points;

  List<Offset>? _pointAlignments;

  final bool _close;

  EtchPathAddPolygon({
    required List<Offset> points,
    bool close = true,
  })  : _points = points,
        _close = close;

  EtchPathAddPolygon.alignment({
    required List<Offset> pointAlignments,
    bool close = true,
  })  : _pointAlignments = pointAlignments,
        _close = close;

  List<Offset> _getEffectiveEnds(Size size) {
    if (_points != null) {
      return _points!;
    }

    var convUnits =
        _pointAlignments!.map((e) => e + const Offset(1, 1)).toList();
    var effectiveOffset = size / 2;

    return convUnits
        .map((e) =>
            Offset(e.dx * effectiveOffset.width, e.dy * effectiveOffset.height))
        .toList();
  }

  @override
  void addToPath(Path path, Canvas canvas, Size size) {
    var p = _getEffectiveEnds(size);
    path.addPolygon(p, _close);
  }

  @override
  bool shouldRepaint(covariant EtchPathElement oldElement) {
    if (oldElement.runtimeType != runtimeType) {
      return true;
    }

    var e = oldElement as EtchPathAddPolygon;

    return _points != e._points || _pointAlignments != e._pointAlignments;
  }
}
