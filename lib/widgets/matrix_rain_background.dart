import 'dart:math';
import 'package:flutter/material.dart';

// Reusable "digital rain" background — dinededesign para gamitin sa
// lahat ng screens (Login, Sign-Up, Home) para consistent yung Matrix theme.
// Basta i-wrap mo lang yung content mo sa loob nito.
class MatrixRainBackground extends StatefulWidget {
  final Widget child;
  const MatrixRainBackground({super.key, required this.child});

  @override
  State<MatrixRainBackground> createState() => _MatrixRainBackgroundState();
}

class _MatrixRainBackgroundState extends State<MatrixRainBackground>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  final Random _random = Random();
  final List<_RainColumn> _columns = [];
  bool _initialized = false;

  @override
  void initState() {
    super.initState();
    // Continuous animation loop — ito ang nagpapagalaw sa "falling code"
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    )..repeat();
  }

  void _setupColumns(double width, double height) {
    if (_initialized) return;
    const columnWidth = 18.0;
    final columnCount = (width / columnWidth).ceil();
    for (int i = 0; i < columnCount; i++) {
      _columns.add(_RainColumn(
        x: i * columnWidth,
        speed: 2 + _random.nextDouble() * 4,
        y: _random.nextDouble() * height,
        length: 5 + _random.nextInt(15),
      ));
    }
    _initialized = true;
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        _setupColumns(constraints.maxWidth, constraints.maxHeight);
        return Stack(
          children: [
            // Black base layer
            Container(color: Colors.black),

            // Animated rain layer — low opacity para hindi ma-distract sa forms
            Positioned.fill(
              child: AnimatedBuilder(
                animation: _controller,
                builder: (context, _) {
                  for (final col in _columns) {
                    col.y += col.speed;
                    if (col.y - (col.length * 16) > constraints.maxHeight) {
                      col.y = -_random.nextDouble() * 200;
                    }
                  }
                  return CustomPaint(
                    size: Size(constraints.maxWidth, constraints.maxHeight),
                    painter: _RainPainter(_columns),
                  );
                },
              ),
            ),

            // Actual screen content sits on top
            widget.child,
          ],
        );
      },
    );
  }
}

class _RainColumn {
  double x;
  double y;
  double speed;
  int length;
  _RainColumn({
    required this.x,
    required this.y,
    required this.speed,
    required this.length,
  });
}

class _RainPainter extends CustomPainter {
  final List<_RainColumn> columns;
  static const String _chars =
      'アイウエオカキクケコ0123456789ABCDEFGHIJKLM';
  final Random _rand = Random();

  _RainPainter(this.columns);

  @override
  void paint(Canvas canvas, Size size) {
    for (final col in columns) {
      for (int i = 0; i < col.length; i++) {
        final charY = col.y - (i * 16);
        if (charY < 0 || charY > size.height) continue;

        final opacity = (1 - (i / col.length)).clamp(0.0, 1.0) * 0.5;
        final char = _chars[_rand.nextInt(_chars.length)];

        final textPainter = TextPainter(
          text: TextSpan(
            text: char,
            style: TextStyle(
              color: const Color(0xFF00FF41).withOpacity(opacity),
              fontSize: 14,
              fontFamily: 'monospace',
            ),
          ),
          textDirection: TextDirection.ltr,
        );
        textPainter.layout();
        textPainter.paint(canvas, Offset(col.x, charY));
      }
    }
  }

  @override
  bool shouldRepaint(covariant _RainPainter oldDelegate) => true;
}
