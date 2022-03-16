import 'package:etch/etch.dart';
import 'package:flutter/material.dart';

/// Creates a separate canvas layer which can have its own transformation
class EtchLayer extends EtchElement {
  /// Elements to paint inside the canvas layer
  final List<EtchElement> etchElements;

  /// Transform which is applied to this layer
  final Matrix4 _transform;

  /// Default constructor which can be supplied with a [Matrix4] transformation for the canvas layer
  EtchLayer({
    required this.etchElements,
    Matrix4? transform,
  }) : _transform = transform ?? Matrix4.identity();

  /// Creates a canvas layer with this translation
  EtchLayer.translate({
    required this.etchElements,
    Offset translate = const Offset(0, 0),
  }) : _transform = Matrix4.identity()..translate(translate.dx, translate.dy);

  /// Creates a canvas layer with this scale
  EtchLayer.scale({
    required this.etchElements,
    Offset scale = const Offset(0, 0),
  }) : _transform = Matrix4.identity()..scale(scale.dx, scale.dy);

  /// Creates a canvas layer with this rotation
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
