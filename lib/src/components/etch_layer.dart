import 'package:etch/etch.dart';
import 'package:flutter/material.dart';

class EtchLayer extends EtchElement {
  final List<EtchElement> etchElements;

  final Matrix4 _transform;

  EtchLayer({
    required this.etchElements,
    Matrix4? transform,
  }) : _transform = transform ?? Matrix4.identity();

  EtchLayer.translate({
    required this.etchElements,
    Offset translate = const Offset(0, 0),
  }) : _transform = Matrix4.identity()..translate(translate.dx, translate.dy);

  EtchLayer.scale({
    required this.etchElements,
    Offset scale = const Offset(0, 0),
  }) : _transform = Matrix4.identity()..scale(scale.dx, scale.dy);

  EtchLayer.rotate({
    required this.etchElements,
    double rotateX = 0.0,
    double rotateY = 0.0,
    double rotateZ = 0.0,
  }) : _transform = Matrix4.identity()
          ..rotateX(rotateX)
          ..rotateY(rotateY)
          ..rotateZ(rotateZ);

  @override
  void paint(Canvas canvas, Size size) {
    canvas.save();
    canvas.transform(_transform.storage);
    for (var e in etchElements) {
      e.paint(canvas, size);
    }
    canvas.restore();
  }

  @override
  bool shouldRepaint(covariant EtchElement oldElement) {
    if (oldElement.runtimeType != runtimeType) {
      return true;
    }

    var e = oldElement as EtchLayer;

    if (e.etchElements.length != etchElements.length) {
      return true;
    }

    for (int i = 0; i < etchElements.length; i++) {
      if (etchElements[i].shouldRepaint(e.etchElements[i])) {
        return true;
      }
    }

    return false;
  }
}
