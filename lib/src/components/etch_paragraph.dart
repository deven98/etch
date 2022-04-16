import 'package:etch/src/components/etch_element.dart';
import 'package:etch/src/components/etch_style.dart';
import 'package:flutter/material.dart';
import 'dart:ui' as ui;

/// Draws text on the screen
class EtchParagraph extends EtchElement {
  /// Offset for painting the text in pixel terms
  Offset? _offset;

  /// Offset for painting the text in alignment terms
  Offset? _offsetAlignment;

  /// Paragraph for rendering
  final ui.Paragraph _paragraph;

  EtchParagraph({
    required ui.Paragraph paragraph,
    required Offset offset,
    EtchStyle? etchStyle,
  })  : _paragraph = paragraph,
        _offset = offset;

  EtchParagraph.alignment({
    required ui.Paragraph paragraph,
    required Offset offsetAlignment,
    EtchStyle? etchStyle,
  })  : _paragraph = paragraph,
        _offsetAlignment = offsetAlignment;

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
    canvas.drawParagraph(_paragraph, _getEffectiveStart(size));
  }

  @override
  bool shouldRepaint(covariant EtchElement oldElement) {
    if (oldElement.runtimeType != runtimeType) {
      return true;
    }

    var e = oldElement as EtchParagraph;

    return _offset != e._offset || _offsetAlignment != e._offsetAlignment;
  }
}
