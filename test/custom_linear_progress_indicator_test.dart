import 'package:custom_linear_progress_indicator/custom_linear_progress_indicator.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('adds one to input values', () {
    const calculator = CustomLinearProgressIndicator(
      progressPercent: 0.5,
    );
    expect(calculator.addOne(2), 3);
    expect(calculator.addOne(-7), -6);
    expect(calculator.addOne(0), 1);
  });
}
