<!-- 
This README describes the package. If you publish this package to pub.dev,
this README's contents appear on the landing page for your package.

For information about how to write a good package README, see the guide for
[writing package pages](https://dart.dev/guides/libraries/writing-package-pages). 

For general information about developing packages, see the Dart guide for
[creating packages](https://dart.dev/guides/libraries/create-library-packages)
and the Flutter guide for
[developing packages and plugins](https://flutter.dev/developing-packages). 
-->

# ✍️Etch

### A Simplified, Declarative Implementation Of CustomPaint For Flutter

## Features

* Create your CustomPaint widget declaratively.

```dart
    EtchCanvas(
        etchElements: [
            EtchCircle.alignment(
                centerAlignment: Offset.zero,
                radius: 50.0,
            ),
        ],
        child: SizedBox(
          width: 100.0,
          height: 100.0,
        ),
    ),
```

* Use either points or alignments to define points everywhere

```dart
    EtchCanvas(
        etchElements: [
            EtchCircle(
              center: Offset(100, 100),
              radius: 50.0,
            ),
            EtchCircle.alignment(
               centerAlignment: Offset.zero,
               radius: 50.0,
               etchStyle: EtchStyle(
                   color: Colors.red,
               ),
           ),
        ],
        child: SizedBox(
          width: 100.0,
          height: 100.0,
        ),
    ),
```

* Easy support for Paths

```dart
    EtchCanvas(
      etchPathElements: [
        EtchPathMoveTo(point: Offset(0, 0)),
        EtchPathAddPolygon.alignment(
          pointAlignments: [
            Offset(-1, -1),
            Offset(1, -1),
            Offset(1, 1),
          ],
        ),
        EtchPathQuadraticBezierTo.alignment(
          controlPointAlignment: Offset(1, 0.75),
          endPointAlignment: Offset(-1, 1),
        ),
        EtchPathClose(),
      ],
      child: SizedBox(
        width: 100.0,
        height: 100.0,
      ),
    ),
```

* Work with canvas layers easily

```dart
    EtchCanvas(
      etchElements: [
        EtchLayer.rotate(
          rotateZ: 1.2,
          etchElements: [
            EtchRect.alignment(
              topLeftAlignment: Offset(-1, -1),
              bottomRightAlignment: Offset(1, 1),
            ),
          ],
        ),
      ],
      child: SizedBox(
        width: 100.0,
        height: 100.0,
      ),
    ),
```

* Easy animations with `TweenAnimationBuilder`

Add animations easily using `TweenAnimationBuilder` or using normal animation controllers without
having to pass down progress or having

```dart
    TweenAnimationBuilder<double>(
      duration: const Duration(seconds: 1),
      tween: Tween(begin: 0, end: 2 * pi),
      builder: (context, val, _) {
        return EtchCanvas(
          etchElements: [
            EtchLayer.rotate(
              rotateZ: val,
              etchElements: [
                EtchRect.alignment(
                  topLeftAlignment: Offset(-1, -1),
                  bottomRightAlignment: Offset(1, 1),
                ),
              ],
            ),
          ],
          child: const SizedBox(
            width: 100.0,
            height: 100.0,
          ),
        );
      }
    ),
```

## Getting started

* To get started, add an `EtchCanvas` to your app:

```dart
    EtchCanvas(
        etchElements: [],
    ),
```

Any elements which have the format 'Etch----' can fit into these (`EtchParagraph`, `EtchPath`, `EtchCircle`, etc).

The default constructor arguments usually take in points while the `.alignment` constructor takes in
alignments. For alignments (-1, -1) is the top left while (1, 1) is the bottom right.

```dart
    EtchCanvas(
        etchElements: [
            EtchRect.alignment(
              topLeftAlignment: Offset.zero,
              bottomRightAlignment: Offset(1, 1),
            ),
            EtchOval.alignment(
              topLeftAlignment: Offset(-1, -1),
              bottomRightAlignment: Offset(0, 0),
            ),
            EtchArc.alignment(
              topLeftAlignment: Offset(-1, -1),
              bottomRightAlignment: Offset(1, 1),
              startAngle: 0,
              sweepAngle: 2,
            ),
        ],
    ),
```

* Use `EtchStyle` to modify paint properties.

```dart
    EtchPath(
      etchPathElements: [
        //...
      ],
      etchStyle: EtchStyle(
        style: PaintingStyle.stroke,
      ),
    ),
```

You can also supply your own `Paint` object using `EtchStyle.raw()`.

```dart
    EtchPath(
      etchPathElements: [
        //...
      ],
      etchStyle: EtchStyle.raw(
        Paint()..color = Colors.black..// add your props,
      ),
    ),
```

* To add a path to the elements, use `EtchPath`. Etch path elements have the naming format `EtchPath---`
(`EtchPathAddPolygon`, `EtchPathAddArc`, `EtchPathCubicTo`, etc)

```dart
    EtchCanvas(
        etchElements: [
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
        ],
    ),
```

* To add a layer, use the `EtchLayer` element. This can have numerous EtchElements inside just like the
normal `EtchCanvas`. Layers can have individual transformations without affecting the rest of the canvas -
so you can rotate or scale one layer without affecting the others. `EtchLayer`, like the `Transform` widget,
has multiple inbuilt transformations - but you can pass in your own `Matrix4` using the default constructor.

```dart
    EtchCanvas(
        etchElements: [
            EtchLayer.rotate(
              rotateX: 1.2,
              etchElements: [
                EtchRect.alignment(
                  topLeftAlignment: Offset(-1, -1),
                  bottomRightAlignment: Offset(1, 1),
                ),
              ],
            ),
            EtchLayer.scale(
              scale: Offset(1, 2),
              etchElements: [
                EtchRect.alignment(
                  topLeftAlignment: Offset(-1, -1),
                  bottomRightAlignment: Offset(1, 1),
                ),
              ],
            ),
            EtchLayer(
              transform: Matrix4.identity(),
              etchElements: [
                EtchRect.alignment(
                  topLeftAlignment: Offset(-1, -1),
                  bottomRightAlignment: Offset(1, 1),
                ),
              ],
            ),
        ],
    ),
```

## Additional information

Note: This package is currently in an experimental stage and full metrics are not yet ascertained.
Please feel free to launch issues or PRs if you face something unexpected while using it.
