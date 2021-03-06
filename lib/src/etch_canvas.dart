import 'package:etch/src/components/etch_element.dart';
import 'package:flutter/material.dart';

/// Main canvas for etch
class EtchCanvas extends StatelessWidget {
  /// [etchElements] to be painted onto the canvas
  final List<EtchElement> etchElements;

  /// [child] corresponding to the usual [CustomPaint] child property
  final Widget? child;

  const EtchCanvas({
    Key? key,
    this.child,
    required this.etchElements,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: EtchPainter(elements: etchElements),
      child: child,
    );
  }
}

/// [CustomPainter] to paint [EtchElement]s given to the canvas
class EtchPainter extends CustomPainter {
  final List<EtchElement> elements;

  EtchPainter({required this.elements});

  @override
  void paint(Canvas canvas, Size size) {
    for (var e in elements) {
      e.paint(canvas, size);
    }
  }

  @override
  bool shouldRepaint(covariant EtchPainter oldDelegate) {
    if (oldDelegate.elements.length != elements.length) {
      return true;
    }

    for (int i = 0; i < elements.length; i++) {
      if (elements[i].shouldRepaint(oldDelegate.elements[i])) {
        return true;
      }
    }

    return false;
  }
}
