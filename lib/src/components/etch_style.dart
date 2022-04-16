import 'dart:ui';

import 'package:flutter/material.dart';

class EtchStyle {
  late Paint paint;

  EtchStyle.raw(this.paint);

  EtchStyle({
    Color color = Colors.black,
    double strokeWidth = 2.0,
    StrokeCap strokeCap = StrokeCap.round,
    StrokeJoin strokeJoin = StrokeJoin.miter,
    BlendMode blendMode = BlendMode.srcOver,
    PaintingStyle style = PaintingStyle.fill,
    FilterQuality filterQuality = FilterQuality.none,
    bool isAntiAlias = true,
    MaskFilter? maskFilter,
    Shader? shader,
    ColorFilter? colorFilter,
    ImageFilter? imageFilter,
  }) : paint = Paint()
          ..color = color
          ..strokeWidth = strokeWidth
          ..strokeCap = strokeCap
          ..strokeJoin = strokeJoin
          ..blendMode = blendMode
          ..style = style
          ..isAntiAlias = isAntiAlias
          ..filterQuality = filterQuality
          ..maskFilter = maskFilter
          ..shader = shader
          ..colorFilter = colorFilter
          ..imageFilter = imageFilter;

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }

    return other is EtchStyle && paint == other.paint;
  }

  @override
  int get hashCode => paint.hashCode;
}
