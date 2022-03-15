import 'dart:ui';

import 'package:flutter/material.dart';

class EtchPaint {
  late Paint paint;

  EtchPaint.raw(this.paint);

  EtchPaint({
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
}
