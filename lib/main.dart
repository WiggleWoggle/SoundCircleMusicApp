import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:device_preview/device_preview.dart';
import 'package:flutter_inner_shadow/flutter_inner_shadow.dart';

void main() {

  runApp(DevicePreview(builder: (context) => MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SoundCircle',

      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {

  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Align(
        alignment: Alignment.center,
        child: Stack(
          children: [
            Align(
              alignment: Alignment.center,
              child: GlassContainer(
                width: 300,
                height: 60,
                red: 232,
                green: 96,
                blue: 170,
                radius: 20,
              ),
            ),
            Align(
              alignment: Alignment.center,
              child: GlassContainer(
                width: 200,
                height: 400,
                red: 255,
                green: 255,
                blue: 255,
                bottomLeftBorderRadius: 20,
                topLeftBorderRadius: 20,
                bottomRightBorderRadius: 0,
                topRightBorderRadius: 0,
                opacity: 0.2,
              ),
            ),
            
          ],
        )
      )
    );
  }
}

class GlassContainer extends StatelessWidget {

  final double width;
  final double height;

  final double radius;

  final double topLeftBorderRadius;
  final double topRightBorderRadius;
  final double bottomLeftBorderRadius;
  final double bottomRightBorderRadius;

  final int red;
  final int green;
  final int blue;

  final double brightness;

  final double opacity;
  final double blur;

  const GlassContainer({
    super.key,
    required this.width,
    required this.height,
    required this.red,
    required this.green,
    required this.blue,
    this.brightness = 0.6,
    this.topLeftBorderRadius = 0,
    this.topRightBorderRadius = 0,
    this.bottomLeftBorderRadius = 0,
    this.bottomRightBorderRadius = 0,
    this.radius = 0,
    this.opacity = 0.8,
    this.blur = 3
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.only(
          topLeft: Radius.circular(topLeftBorderRadius),
          bottomLeft: Radius.circular(bottomLeftBorderRadius),
          topRight: Radius.circular(topRightBorderRadius),
          bottomRight: Radius.circular(bottomRightBorderRadius)
      ),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: blur, sigmaY: blur),
        child: InnerShadow(
          shadows: [
            Shadow(
              color: Colors.white.withOpacity(0.5),
              blurRadius: 6,
              offset: Offset(1, 4),
            ),
          ],
          child: Container(
            width: width,
            height: height,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                  topLeft: (radius == 0) ? Radius.circular(topLeftBorderRadius) : Radius.circular(radius),
                  bottomLeft: (radius == 0) ? Radius.circular(bottomLeftBorderRadius) : Radius.circular(radius),
                  topRight: (radius == 0) ? Radius.circular(topRightBorderRadius) : Radius.circular(radius),
                  bottomRight: (radius == 0) ? Radius.circular(bottomRightBorderRadius) : Radius.circular(radius)
              ),
              border: Border.all(
                color: Colors.white.withOpacity(0.3),
                width: 1.5,
              ),
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  HSLColor.fromColor(Color.fromRGBO(red, green, blue, opacity))
                      .withLightness(brightness)
                      .toColor(),
                  Color.fromRGBO(red, green, blue, opacity),
                ],
              ),
              /*
              boxShadow: [
                BoxShadow(
                  color: Colors.white.withOpacity(0.15),
                  blurRadius: 20,
                  offset: Offset(-5, -5),
                ),
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 20,
                  offset: Offset(5, 5),
                ),
              ],
               */
            ),
          ),
        )
      ),
    );
  }
}