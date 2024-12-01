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
    // Background
    final backgroundPaint = Paint()
      ..color = backgroundColor
      ..style = PaintingStyle.fill;

    final backgroundRect = RRect.fromRectAndRadius(
      Rect.fromLTWH(0, 0, size.width, size.height),
      Radius.circular(borderRadius),
    );
    canvas.drawRRect(backgroundRect, backgroundPaint);

    // Progress
    if (value > 0) {
      final progressPaint = Paint()
        ..color = valueColor
        ..style = PaintingStyle.fill;

      final progressWidth = size.width * value;
      final progressRect = RRect.fromRectAndCorners(
        Rect.fromLTWH(0, 0, progressWidth, size.height),
        topLeft: Radius.circular(borderRadius),
        bottomLeft: Radius.circular(borderRadius),
        topRight: Radius.circular(value == 1.0 ? borderRadius : linearProgressBarBorderRadius),
        bottomRight: Radius.circular(value == 1.0 ? borderRadius : linearProgressBarBorderRadius),
      );
      canvas.drawRRect(progressRect, progressPaint);

      // Border for progress
      final progressBorderPaint = Paint()
        ..color = borderColor
        ..style = PaintingStyle.stroke
        ..strokeWidth = borderWidth;

      canvas.drawRRect(progressRect, progressBorderPaint);
    }

    // Outer Border
    final borderPaint = Paint()
      ..color = borderColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = borderWidth;

    canvas.drawRRect(backgroundRect, borderPaint);
  }

  @override
  bool shouldRepaint(covariant CustomProgressBarPainter oldDelegate) {
    return oldDelegate.value != value ||
        oldDelegate.borderRadius != borderRadius ||
        oldDelegate.borderColor != borderColor ||
        oldDelegate.borderStyle != borderStyle ||
        oldDelegate.borderWidth != borderWidth ||
        oldDelegate.backgroundColor != backgroundColor ||
        oldDelegate.valueColor != valueColor ||
        oldDelegate.linearProgressBarBorderRadius != linearProgressBarBorderRadius;
  }
}
