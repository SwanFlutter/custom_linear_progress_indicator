library;

import 'package:custom_linear_progress_indicator/src/widget/custom_progress_bar_painter.dart';
import 'package:flutter/material.dart';

class CustomLinearProgressIndicator extends StatefulWidget {
  /// [value]: A double value representing the current progress percentage (0.0 to 1.0).
  final double value;

  /// [animationDuration]: An integer controlling the duration of the progress animation in milliseconds.
  final int animationDuration;

  /// /// [borderRadius]: A double value controlling the overall border radius of the progress bar.
  final double borderRadius;

  /// [borderColor]: A Color value specifying the color of the progress bar's border.
  final Color borderColor;

  /// [borderStyle]: A BorderStyle value defining the style of the border (e.g., solid, dashed).
  final BorderStyle borderStyle;

  ///borderWidth: A double value setting the width of the border.
  final double borderWidth;

  /// [backgroundColor]: A Color value representing the background color of the progress bar.
  final Color backgroundColor;

  /// [linearProgressBarBorderRadius]: A double value specifically adjusting the border radius of the linear progress bar element within the overall progress bar.
  final double linearProgressBarBorderRadius;

  /// [minHeight]: A double value setting the minimum height of the progress bar.
  final double minHeight;

  /// [colorLinearProgress]: A Color value indicating the color of the filled progress portion.
  final Color colorLinearProgress;

  /// [onProgressChanged]: A callback function that is triggered when the progress value changes.
  final ValueChanged<double>? onProgressChanged;

  /// [percentTextStyle]: A TextStyle value specifying the text style for the percentage text.
  final TextStyle? percentTextStyle;

  /// [showPercent]: A bool value indicating whether to show the percentage text or not.
  final bool showPercent;

  /// [progressAnimationCurve]: A Curve value specifying the curve for the progress animation.
  final Curve progressAnimationCurve;

  /// [alignment]: An AlignmentGeometry value specifying the alignment of the progress bar within its container.
  final AlignmentGeometry alignment;

  /// [maxValue]: A double value representing the maximum value for the progress bar.
  ///
  /// Defaults 0 to 1.0.
  ///
  /// You can set this value to more than 100%.
  final double maxValue;

  /// [gradientColors]: A List<Color> value specifying the colors for the gradient fill of the progress bar.
  final List<Color>? gradientColors;

  const CustomLinearProgressIndicator({
    super.key,
    required this.value,
    this.animationDuration = 500,
    this.borderRadius = 0,
    this.borderColor = Colors.black,
    this.borderStyle = BorderStyle.solid,
    this.borderWidth = 1,
    this.backgroundColor = Colors.grey,
    this.linearProgressBarBorderRadius = 0,
    this.colorLinearProgress = Colors.blue,
    this.minHeight = 20,
    this.onProgressChanged,
    this.percentTextStyle,
    this.showPercent = false,
    this.progressAnimationCurve = Curves.easeInOut,
    this.alignment = Alignment.center,
    this.maxValue = 1.0,
    this.gradientColors,
  });

  @override
  State<CustomLinearProgressIndicator> createState() =>
      _CustomLinearProgressIndicatorState();
}

class _CustomLinearProgressIndicatorState
    extends State<CustomLinearProgressIndicator>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;
  late double _previousValue = 0.0;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: widget.animationDuration),
    );
    _updateAnimation();
  }

  void _updateAnimation() {
    final clampedValue = widget.value.clamp(0.0, widget.maxValue);
    final normalizedValue = (clampedValue / widget.maxValue).clamp(0.0, 1.0);
    final normalizedPreviousValue =
        (_previousValue / widget.maxValue).clamp(0.0, 1.0);

    _animation = Tween<double>(
      begin: normalizedPreviousValue,
      end: normalizedValue,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: widget.progressAnimationCurve,
    ))
      ..addListener(() {
        setState(() {});
        if (widget.onProgressChanged != null) {
          widget.onProgressChanged!(clampedValue);
        }
      });
    _animationController.forward(from: 0);
    _previousValue = clampedValue;
  }

  void _refreshAnimation() {
    final clampedValue = widget.value.clamp(0.0, widget.maxValue);
    final normalizedValue = (clampedValue / widget.maxValue).clamp(0.0, 1.0);

    _animation = Tween<double>(
      begin: 0,
      end: normalizedValue,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: widget.progressAnimationCurve,
    ));

    _animationController.forward(from: 0);
    _previousValue = clampedValue;
  }

  @override
  void didUpdateWidget(CustomLinearProgressIndicator oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.value != widget.value ||
        oldWidget.maxValue != widget.maxValue) {
      _updateAnimation();
    }
  }

  void _resetAnimation() {
    _animationController.reset();
    _refreshAnimation();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onDoubleTap: _resetAnimation,
      child: SizedBox(
        height: widget.minHeight,
        child: Stack(
          children: [
            CustomPaint(
              painter: CustomProgressBarPainter(
                value: _animation.value,
                borderRadius: widget.borderRadius,
                borderColor: widget.borderColor,
                borderStyle: widget.borderStyle,
                borderWidth: widget.borderWidth,
                backgroundColor: widget.backgroundColor,
                valueColor: widget.colorLinearProgress,
                linearProgressBarBorderRadius:
                    widget.linearProgressBarBorderRadius,
                gradientColors: widget.gradientColors,
              ),
              size: Size.infinite,
            ),
            if (widget.showPercent)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15.0),
                child: Align(
                  alignment: widget.alignment,
                  child: Text(
                    '${(_animation.value * widget.maxValue * 100).toStringAsFixed(1)}%',
                    style: widget.percentTextStyle,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
