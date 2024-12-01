library custom_linear_progress_indicator;

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

  const CustomLinearProgressIndicator({
    super.key,
    required this.value,
    this.animationDuration = 500,
    this.borderRadius = 0,
    this.borderColor = Colors.white,
    this.borderStyle = BorderStyle.solid,
    this.borderWidth = 1,
    this.backgroundColor = Colors.grey,
    this.linearProgressBarBorderRadius = 0,
    this.colorLinearProgress = Colors.blue,
    this.minHeight = 20,
    this.onProgressChanged,
    this.percentTextStyle,
    this.showPercent = false,
  });

  @override
  State<CustomLinearProgressIndicator> createState() => _CustomLinearProgressIndicatorState();
}

class _CustomLinearProgressIndicatorState extends State<CustomLinearProgressIndicator> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: widget.animationDuration),
    );
    _animationController.reset();
    setState(() {
      _animation = Tween<double>(
        begin: 0,
        end: widget.value,
      ).animate(CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeInOutExpo,
      ));
    });
    _animation.addListener(() {
      if (widget.onProgressChanged != null) {
        widget.onProgressChanged!(_animation.value);
      }
      setState(() {});
    });
    _animationController.forward();
  }

  @override
  void didUpdateWidget(covariant CustomLinearProgressIndicator oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.value != widget.value) {
      _animation = Tween<double>(
        begin: _animation.value,
        end: widget.value,
      ).animate(CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeInOut,
      ))
        ..addListener(
          () {
            if (widget.onProgressChanged != null) {
              widget.onProgressChanged!(_animation.value);
            }
          },
        );
      _animationController.forward(from: 0);
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SizedBox(
      width: size.width,
      height: widget.minHeight,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(widget.borderRadius),
        child: CustomPaint(
          painter: CustomProgressBarPainter(
            value: _animation.value,
            borderRadius: widget.borderRadius,
            borderColor: widget.borderColor,
            borderStyle: widget.borderStyle,
            borderWidth: widget.borderWidth,
            backgroundColor: widget.backgroundColor,
            valueColor: widget.colorLinearProgress,
            linearProgressBarBorderRadius: widget.linearProgressBarBorderRadius,
          ),
          child: widget.showPercent
              ? Center(
                  child: Text(
                    '${(_animation.value * 100).round()}%',
                    style: widget.percentTextStyle,
                  ),
                )
              : const SizedBox.shrink(),
        ),
      ),
    );
  }
}
