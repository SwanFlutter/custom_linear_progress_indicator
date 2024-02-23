library custom_linear_progress_indicator;

import 'package:flutter/material.dart';

import 'widget/custom_progress_bar_painter.dart';

class CustomLinearProgressIndicator extends StatefulWidget {
  /// [progressPercent]: A double value representing the current progress percentage (0.0 to 1.0).
  final double progressPercent;

  /// [animationDurationSeconds]: An integer controlling the duration of the progress animation in seconds.
  final int animationDurationSeconds;

  /// [width]: A double value defining the width of the progress bar.
  final double width;

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

  /// [percentTextStyle]: A TextStyle value customizing the appearance of the optional progress percentage text.
  final TextStyle percentTextStyle;

  /// [minHeight]: A double value setting the minimum height of the progress bar.
  final double minHeight;

  /// [colorLinearProgress]: A Color value indicating the color of the filled progress portion.
  final Color colorLinearProgress;

  const CustomLinearProgressIndicator({
    super.key,
    required this.progressPercent,
    this.animationDurationSeconds = 1,
    this.width = 1,
    this.borderRadius = 0,
    this.borderColor = Colors.white,
    this.borderStyle = BorderStyle.solid,
    this.borderWidth = 1,
    this.backgroundColor = Colors.grey,
    this.linearProgressBarBorderRadius = 0,
    this.colorLinearProgress = Colors.blue,
    this.percentTextStyle = const TextStyle(
      color: Colors.orange,
      fontSize: 12.0,
      fontWeight: FontWeight.w800,
    ),
    this.minHeight = 20,
  });

  @override
  State<CustomLinearProgressIndicator> createState() =>
      _CustomLinearProgressIndicatorState();

  addOne(int i) {}
}

class _CustomLinearProgressIndicatorState
    extends State<CustomLinearProgressIndicator>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;
  double _currentValue = 0;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(seconds: widget.animationDurationSeconds),
    );
    _updateProgress();
  }

  void _updateProgress() {
    setState(() {
      _animationController.reset();
      _animation = Tween<double>(begin: 0, end: widget.progressPercent)
          .animate(_animationController)
        ..addListener(() {
          setState(() {
            _currentValue = _animation.value;
          });
        });
      _animationController.forward();
    });
  }

  void _restartAnimation() {
    setState(() {
      _currentValue = 0;
    });
    _animationController.reset();

    _animationController.forward();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return InkWell(
      onTap: () => _restartAnimation(),
      child: SizedBox(
        width: size.width * widget.width,
        height: widget.minHeight,
        child: CustomPaint(
          painter: CustomProgressBarPainter(
            progressPercent: _currentValue,
            borderRadius: widget.borderRadius,
            borderColor: widget.borderColor,
            borderStyle: widget.borderStyle,
            borderWidth: widget.borderWidth,
            backgroundColor: widget.backgroundColor,
            valueColor: widget.colorLinearProgress,
            linearProgressBarBorderRadius: widget.linearProgressBarBorderRadius,
          ),
          child: Stack(
            alignment: Alignment.center,
            children: [
              Text(
                '${(_currentValue * 100).round()}%',
                style: widget.percentTextStyle,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
