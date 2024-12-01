Provides a customizable linear progress indicator widget for Flutter applications, offering animation and visual customization options.

## Features

![20240223_061849](https://github.com/SwanFlutter/custom_linear_progress_indicator/assets/151648897/090007b6-b92c-47c7-abf4-064cb5b5cf7e)


## Getting started

```yaml
dependencies:
   custom_linear_progress_indicator: ^0.0.1

```
## How to use

```dart
import 'package:custom_linear_progress_indicator/custom_linear_progress_indicator.dart';

```
## Usage

```dart
CustomLinearProgressIndicator(
borderColor: Colors.blue,
borderWidth: 3,
progressPercent: double.tryParse((users / total).toStringAsFixed(2))!,
width: 0.8,
colorLinearProgress: Colors.black87,
animationDurationSeconds: 2,
 minHeight: 50,
linearProgressBarBorderRadius: 12.0,
borderRadius: 12.0,
backgroundColor: const Color.fromRGBO(224, 224, 224, 1),
percentTextStyle: const TextStyle(
color: Colors.blue,
fontSize: 20,
fontWeight: FontWeight.w800,
),
),
```

## Additional information

If you have any issues, questions, or suggestions related to this package, please feel free to contact us at [swan.dev1993@gmail.com](mailto:swan.dev1993@gmail.com). We welcome your feedback and will do our best to address any problems or provide assistance.
For more information about this package, you can also visit our [GitHub repository](https://github.com/SwanFlutter/custom_linear_progress_indicator) where you can find additional resources, contribute to the package's development, and file issues or bug reports. We appreciate your contributions and feedback, and we aim to make this package as useful as possible for our users.

Thank you for using our package, and we look forward to hearing from you!
