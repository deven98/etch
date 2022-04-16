import 'package:etch/src/components/etch_element.dart';
import 'package:etch/src/components/etch_style.dart';
import 'package:flutter/material.dart';
import 'dart:ui' as ui;

/// Draws an image on the canvas
class EtchImage extends EtchElement {
  Offset? _offset;

  /// [EtchStyle] to use for painting the element
  final EtchStyle etchStyle;

  Offset? _offsetAlignment;

  final ui.Image _image;

  EtchImage({
    required ui.Image image,
    required Offset offset,
    EtchStyle? etchStyle,
  })  : _image = image,
        _offset = offset,
        etchStyle = etchStyle ?? EtchStyle();

  EtchImage.alignment({
    required ui.Image image,
    required Offset offsetAlignment,
    EtchStyle? etchStyle,
  })  : _image = image,
        _offsetAlignment = offsetAlignment,
        etchStyle = etchStyle ?? EtchStyle();

  Offset _getEffectiveStart(Size size) {
    if (_offset != null) {
      return _offset!;
    }

    var convUnits = _offsetAlignment! + const Offset(1, 1);
    var effectiveOffset = size / 2;

    return Offset(convUnits.dx * effectiveOffset.width,
        convUnits.dy * effectiveOffset.height);
  }

  @override
  void paint(Canvas canvas, Size size) {
    canvas.drawImage(_image, _getEffectiveStart(size), etchStyle.paint);
  }

  @override
  bool shouldRepaint(covariant EtchElement oldElement) {
    if (oldElement.runtimeType != runtimeType) {
      return true;
    }

    var e = oldElement as EtchImage;

    return _offset != e._offset ||
        _offsetAlignment != e._offsetAlignment ||
        etchStyle != e.etchStyle;
  }
}
