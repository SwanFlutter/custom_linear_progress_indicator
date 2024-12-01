import 'dart:developer';

import 'package:custom_linear_progress_indicator/custom_linear_progress_indicator.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({
    super.key,
  });

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  DateTime selectedData = DateTime.now();
  late double progressPercent = 0.1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // you can click double tap to reset progress
            CustomLinearProgressIndicator(
              maxValue: 1, // new
              value: progressPercent,
              minHeight: 50,
              borderWidth: 4,
              borderColor: Colors.black,
              borderStyle: BorderStyle.solid,
              colorLinearProgress: Colors.yellow,
              animationDuration: const Duration(seconds: 1),
              borderRadius: 100,
              linearProgressBarBorderRadius: 100,
              backgroundColor: Colors.green.shade50,
              progressAnimationCurve: Curves.ease, // new
              alignment: Alignment.center, // new
              showPercent: true, // new
              percentTextStyle: const TextStyle(fontWeight: FontWeight.bold),
              onProgressChanged: (double value) {},
              // New
              progressGradient: const LinearGradient(
                colors: [
                  Colors.red,
                  Colors.yellow,
                  Colors.green,
                ],
              ),
            ),
            const SizedBox(height: 30),
            TextButton(
              onPressed: () {
                setState(() {
                  progressPercent += 0.3;
                });

                log(progressPercent.toString());
              },
              child: const Text('Change Progress'),
            ),
          ],
        ),
      ),
    );
  }
}
