import 'dart:ui' as ui;

import 'package:activity_ring/src/color.dart';
import 'package:activity_ring/src/painter.dart';
import 'package:flutter/material.dart';

/// A progress indicator widget with Apple Watch Rings style
class Ring extends StatefulWidget {
  // ignore: public_member_api_docs
  const Ring({
    required this.percent,
    required this.childBuilder,
    required this.color,
    this.center,
    this.radius,
    this.width = 25.0,
    this.showBackground = true,
    this.animate = true,
    this.curve,
    this.duration,
    this.tip,
    Key? key,
  }) : super(key: key);

  /// Percent of ring to paint.
  ///
  /// Pass the value after * 100 like 8.9 instead of 0.089
  final double percent;

  /// Ring's color.
  final RingColorScheme color;

  /// Center for this ring.
  final Offset? center;

  /// Ring's radius.
  ///
  /// If null parent widget's Size will be used.
  /// Then radius = (min(size.width, size.height) - strokeWidth) / 2
  final double? radius;

  /// Ring's width.
  final double width;

  /// True if this ring should have backround ring.
  final bool showBackground;

  /// Duration of animation
  final Duration? duration;

  /// If true then ring will be animated to fill [percent]
  final bool animate;

  /// Curve to animate the ring
  final Curve? curve;

  /// Tip of the ring
  final ui.Image? tip;

  final Widget Function(double percent) childBuilder;

  @override
  State<Ring> createState() => _RingState();
}

class _RingState extends State<Ring> {
  @override
  Widget build(BuildContext context) {
    final animatedRing = TweenAnimationBuilder(
      tween: Tween<double>(begin: 0, end: widget.percent),
      curve: widget.curve ?? Curves.easeOutQuad,
      duration:
          widget.duration ?? Duration(seconds: (widget.percent ~/ 100) + 1),
      builder: (_, percent, child) {
        //testFunction!(percent);
        return Stack(
          alignment: Alignment.center,
          children: [
            CustomPaint(
              painter: DrawRing(
                percent: percent,
                color: widget.color,
                width: widget.width,
                center: widget.center,
                radius: widget.radius,
                tip: widget.tip,
              ),
              child: child,
            ),
            widget.childBuilder(percent),
          ],
        );
      },
      //child: widget.childBuilder(widget.percent),
    );
    final staticRing = CustomPaint(
      painter: DrawRing(
        percent: widget.percent,
        color: widget.color,
        width: widget.width,
        center: widget.center,
        radius: widget.radius,
        tip: widget.tip,
      ),
      child: widget.childBuilder(widget.percent),
    );

    return CustomPaint(
      painter: DrawFullRing(
        width: widget.width,
        ringPaint: widget.showBackground
            ? widget.color.backgroundRingPaint(widget.width)
            : null,
        center: widget.center,
        radius: widget.radius,
      ),
      child: widget.animate ? animatedRing : staticRing,
    );
  }
}
