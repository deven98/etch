import 'dart:ui';

import 'package:etch/src/components/etch_element.dart';
import 'package:etch/src/components/etch_style.dart';

class EtchVertices extends EtchElement {
  final Vertices _vertices;
  final BlendMode _blendMode;

  final EtchStyle etchStyle;

  EtchVertices({
    required Vertices vertices,
    BlendMode blendMode = BlendMode.srcOver,
    EtchStyle? etchStyle,
  })  : _vertices = vertices,
        _blendMode = blendMode,
        etchStyle = etchStyle ?? EtchStyle();

  @override
  void paint(Canvas canvas, Size size) {
    canvas.drawVertices(_vertices, _blendMode, etchStyle.paint);
  }

  @override
  bool shouldRepaint(covariant EtchElement oldElement) {
    if (oldElement.runtimeType != runtimeType) {
      return true;
    }

    var e = oldElement as EtchVertices;

    return etchStyle != e.etchStyle ||
        _blendMode != e._blendMode ||
        _vertices != e._vertices;
  }
}
