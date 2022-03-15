import 'dart:ui';

import 'package:etch/src/components/etch_element.dart';
import 'package:etch/src/components/etch_paint.dart';
import 'package:flutter/material.dart';

class EtchClipRect extends EtchElement {
  Rect? _rect;

  Offset? _topLeftAlignment;
  Offset? _bottomRightAlignment;

  ClipOp _clipOp;
  bool _doAntiAlias;

  EtchClipRect({
    required Rect rect,
    ClipOp clipOp = ClipOp.intersect,
    bool doAntiAlias = true,
  })  : _rect = rect,
        _clipOp = clipOp,
        _doAntiAlias = true;

  EtchClipRect.alignment({
    required Offset topLeftAlignment,
    required Offset bottomRightAlignment,
    ClipOp clipOp = ClipOp.intersect,
    bool doAntiAlias = true,
  })  : _topLeftAlignment = topLeftAlignment,
        _bottomRightAlignment = bottomRightAlignment,
        _clipOp = clipOp,
        _doAntiAlias = true;

  @override
  void paint(Canvas canvas, Size size) {
    canvas.clipRect(
      Rect.fromPoints(
        _getEffectiveStart(size),
        _getEffectiveEnd(size),
      ),
      clipOp: _clipOp,
      doAntiAlias: _doAntiAlias,
    );
  }

  Offset _getEffectiveStart(Size size) {
    if (_rect != null) {
      return _rect!.topLeft;
    }

    var convUnits = _topLeftAlignment! + const Offset(1, 1);
    var effectiveOffset = size / 2;

    return Offset(convUnits.dx * effectiveOffset.width,
        convUnits.dy * effectiveOffset.height);
  }

  Offset _getEffectiveEnd(Size size) {
    if (_rect != null) {
      return _rect!.bottomRight;
    }

    var convUnits = _bottomRightAlignment! + const Offset(1, 1);
    var effectiveOffset = size / 2;

    return Offset(convUnits.dx * effectiveOffset.width,
        convUnits.dy * effectiveOffset.height);
  }

  @override
  bool shouldRepaint(covariant EtchElement oldElement) {
    if (oldElement.runtimeType != runtimeType) {
      return true;
    }

    var e = oldElement as EtchClipRect;

    return _rect != e._rect ||
        _topLeftAlignment != e._topLeftAlignment ||
        _bottomRightAlignment != e._bottomRightAlignment;
  }
}
