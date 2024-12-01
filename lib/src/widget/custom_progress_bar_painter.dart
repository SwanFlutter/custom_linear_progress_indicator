import 'package:flutter/material.dart';

class CustomProgressBarPainter extends CustomPainter {
  /// [value]: A double value representing the current progress percentage (0.0 to 1.0).
  double value;

  /// [borderRadius]: A double value controlling the overall border radius of the progress bar.
  final double borderRadius;

  /// [borderColor]: A Color value specifying the color of the progress bar's border.
  final Color borderColor;

  /// [borderStyle]: A BorderStyle value defining the style of the border (e.g., solid, dashed).
  final BorderStyle borderStyle;

  /// [borderWidth]: A double value setting the width of the border.
  final double borderWidth;

  /// [backgroundColor]: A Color value representing the background color of the progress bar.
  final Color backgroundColor;

  /// [valueColor]: A Color value indicating the color of the filled progress portion.
  final Color valueColor;

  /// [linearProgressBarBorderRadius]: A double value specifically adjusting the border radius of the linear progress bar element within the overall progress bar.
  final double linearProgressBarBorderRadius;

  CustomProgressBarPainter({
    required this.value,
    required this.borderRadius,
    required this.borderColor,
    required this.borderStyle,
    required this.borderWidth,
    required this.backgroundColor,
    required this.valueColor,
    required this.linearProgressBarBorderRadius,
  });

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = backgroundColor
      ..style = PaintingStyle.fill;

    // Draw background container
    RRect backgroundRect = RRect.fromLTRBR(
      0,
      0,
      size.width,
      size.height,
      Radius.circular(borderRadius),
    );
    canvas.drawRRect(backgroundRect, paint);

    RRect? progressBarRect;

    if (value > 0) {
      // Draw progress bar
      paint.color = valueColor;
      double progressBarWidth = size.width * value;
      progressBarRect = RRect.fromLTRBR(
        0,
        0,
        progressBarWidth,
        size.height,
        Radius.circular(linearProgressBarBorderRadius),
      );
      canvas.drawRRect(progressBarRect, paint);
    }

    // Draw border
    paint.style = PaintingStyle.stroke;
    paint.color = borderColor;
    paint.strokeWidth = borderWidth;
    if (progressBarRect != null) {
      canvas.drawRRect(progressBarRect, paint);
    }
    canvas.drawRRect(backgroundRect, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
