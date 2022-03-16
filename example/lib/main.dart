import 'package:etch/etch.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const DemoPage());
  }
}

class DemoPage extends StatefulWidget {
  const DemoPage({Key? key}) : super(key: key);

  @override
  _DemoPageState createState() => _DemoPageState();
}

class _DemoPageState extends State<DemoPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: EtchCanvas(
          etchElements: [
            EtchLayer.scale(
              scale: Offset(1, 2),
              etchElements: [
                EtchLine(start: Offset(0, 0), end: Offset(100, 100)),
                EtchLine(start: Offset(0, 50), end: Offset(100, 100)),
              ],
            ),
            // EtchLayer(
            //   transform: Matrix4.identity(),
            //   etchElements: [
            //     EtchRect.alignment(
            //       topLeftAlignment: Offset(-1, -1),
            //       bottomRightAlignment: Offset(1, 1),
            //     ),
            //   ],
            // ),
            EtchPath(
              etchPathElements: [
                EtchPathMoveTo(point: Offset(0, 0)),
                EtchPathLine(point: Offset(110, 0)),
                EtchPathLine(point: Offset(110, 110)),
                EtchPathClose(),
              ],
              etchStyle: EtchStyle(
                style: PaintingStyle.stroke,
              ),
            ),
            // EtchRect.alignment(
            //   topLeftAlignment: Offset.zero,
            //   bottomRightAlignment: Offset(1, 1),
            // ),
            // EtchOval.alignment(
            //   topLeftAlignment: Offset(-1, -1),
            //   bottomRightAlignment: Offset(0, 0),
            // ),
            // EtchArc.alignment(
            //   topLeftAlignment: Offset(-1, -1),
            //   bottomRightAlignment: Offset(1, 1),
            //   startAngle: 0,
            //   sweepAngle: 2,
            // ),
            // EtchCircle(
            //   center: Offset(100, 100),
            //   radius: 50.0,
            // ),
            EtchPath(
              etchPathElements: [
                EtchPathMoveTo(point: Offset(0, 0)),
                EtchPathAddPolygon.alignment(
                  pointAlignments: [
                    Offset(0, 0),
                    Offset(1, 0),
                    Offset(1, 1),
                  ],
                ),
                EtchPathConicTo.alignment(
                  controlPointAlignment: Offset(0.2, 0.4),
                  endPointAlignment: Offset(0.5, -0.5),
                ),
                EtchPathClose(),
              ],
              etchStyle: EtchStyle(
                style: PaintingStyle.stroke,
              ),
            ),
          ],
          child: SizedBox(
            width: 100.0,
            height: 100.0,
          ),
        ),
      ),
    );
  }
}
