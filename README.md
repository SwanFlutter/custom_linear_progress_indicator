Provides a customizable linear progress indicator widget for Flutter applications, offering animation and visual customization options.

## Features

![20240223_061849](https://github.com/SwanFlutter/custom_linear_progress_indicator/assets/151648897/090007b6-b92c-47c7-abf4-064cb5b5cf7e)


## Getting started

```yaml
dependencies:
   custom_linear_progress_indicator: ^0.0.2

```
## How to use

```dart
import 'package:custom_linear_progress_indicator/custom_linear_progress_indicator.dart';

```
## Usage

```dart
CustomLinearProgressIndicator(
   value: progressPercent,
   minHeight: 50,
   borderWidth: 4,
   borderColor: Colors.yellow.shade900,
   borderStyle: BorderStyle.solid,
   colorLinearProgress: Colors.yellow,
   animationDuration: 1000,
   borderRadius: 20,
   linearProgressBarBorderRadius: 20,
   backgroundColor: Colors.green.shade50,
   showPercent: true,
   percentTextStyle: const TextStyle(fontWeight: FontWeight.bold),
   onProgressChanged: (double value) {
      log('Progress: $value');
   },
),
```

See `/example` folder for better understanding.

## Additional information

If you have any issues, questions, or suggestions related to this package, please feel free to contact us at [swan.dev1993@gmail.com](mailto:swan.dev1993@gmail.com). We welcome your feedback and will do our best to address any problems or provide assistance.
For more information about this package, you can also visit our [GitHub repository](https://github.com/SwanFlutter/custom_linear_progress_indicator) where you can find additional resources, contribute to the package's development, and file issues or bug reports. We appreciate your contributions and feedback, and we aim to make this package as useful as possible for our users.

Thank you for using our package, and we look forward to hearing from you!
