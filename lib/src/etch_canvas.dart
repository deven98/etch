import 'package:etch/src/components/etch_element.dart';
import 'package:flutter/material.dart';

class EtchCanvas extends StatelessWidget {
  final List<EtchElement> children;

  const EtchCanvas({Key? key, required this.children}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: EtchPainter(elements: children),
    );
  }
}

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
    if(oldDelegate.elements.length != elements.length) {
      return true;
    }

    for(int i = 0; i < elements.length; i++) {
      if(elements[i].shouldRepaint(oldDelegate.elements[i])) {
       return true;
      }
    }

    return false;
  }
}