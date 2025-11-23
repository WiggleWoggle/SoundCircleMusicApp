import 'dart:math';
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
              child: MusicBarWidget(),
            )
          ],
        )
      )
    );
  }
}

class MusicBarWidget extends StatefulWidget {

  @override
  State<MusicBarWidget> createState() => _MusicBarWidgetState();
}

class _MusicBarWidgetState extends State<MusicBarWidget> {

  bool expanded = false;
  double expandedOpacity = 1;
  double scale = 1;

  void toggleExpanded() {
    setState(() {
      expanded = !expanded;

      if (expanded) {
        expandedOpacity = 0;
      }
      if (!expanded) {
        expandedOpacity = 1;
      }
    });
  }

  void scaleUpWidget() {
    setState(() {
      scale = 1.1;
    });
  }

  void scaleDownWidget() {
    setState(() {
      scale = 1;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onLongPressStart: (_) {
          scaleUpWidget();
          toggleExpanded();
        },
        onLongPressEnd: (_) {
          scaleDownWidget();
        },
      child: AnimatedScale(
        scale: scale,
        duration: Duration(milliseconds: 500),
        curve: Curves.elasticOut,
        child: Stack(
          children: [
            GlassContainer(
              width: MediaQuery.of(context).size.width * 0.85,
              height: expanded ? MediaQuery.of(context).size.height * 0.65 : MediaQuery.of(context).size.height * 0.073,
              red: 232,
              green: 96,
              blue: 170,
              radius: MediaQuery.of(context).size.width * 0.05,
            ),
            Stack(
              children: [
                AnimatedOpacity(
                  opacity: expandedOpacity,
                  curve: Curves.easeInOutCirc,
                  duration: Duration(milliseconds: 300),
                  child: GlassContainer(
                    width: MediaQuery.of(context).size.width * 0.35,
                    height: MediaQuery.of(context).size.height * 0.073,
                    red: 232,
                    green: 96,
                    blue: 170,
                    topRightBorderRadius: 0,
                    bottomLeftBorderRadius: MediaQuery.of(context).size.width * 0.05,
                    topLeftBorderRadius: MediaQuery.of(context).size.width * 0.05,
                    bottomRightBorderRadius: 0,
                  ),
                ),
              ],
            ),
            Positioned.fill(
              child: AnimatedAlign(
                  alignment: expanded ? Alignment.topCenter : Alignment.centerLeft,
                  duration: Duration(milliseconds: 350),
                  curve: Curves.easeInOutCubic,
                  child: Padding(
                    padding: EdgeInsets.only(
                        left: expanded ? 0 : MediaQuery.of(context).size.width * 0.03,
                      top: expanded ? MediaQuery.of(context).size.width * 0.05 : 0
                    ),
                    child: AnimatedContainer(
                      duration: Duration(milliseconds: 350),
                      curve: Curves.easeInOutCubic,
                      width: expanded ? MediaQuery.of(context).size.width * 0.77 : MediaQuery.of(context).size.width * 0.1,
                      height: expanded ? MediaQuery.of(context).size.width * 0.77 : MediaQuery.of(context).size.width * 0.1,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(expanded ? MediaQuery.of(context).size.width * 0.03 : MediaQuery.of(context).size.width * 0.015),
                        image: DecorationImage(
                          image: AssetImage("assets/images/pinktape.png"),
                          fit: BoxFit.cover,
                        ),
                      ),
                      child: InnerShadow(
                          shadows: [
                            Shadow(
                              color: Colors.white.withOpacity(0.5),
                              blurRadius: 6,
                              offset: Offset(1, 4),
                            ),
                          ],
                      )
                    ),
                  )
              ),
            )
          ],
        ),
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

  final Widget? child;

  final int duration;

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
    this.blur = 3,
    this.child,
    this.duration = 300
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
          child: AnimatedContainer(
            duration: Duration(milliseconds: duration),
            curve: Curves.easeInOutCubic,
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
            child: child,
          ),
        )
      ),
    );
  }
}