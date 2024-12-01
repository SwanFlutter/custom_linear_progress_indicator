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
  late double progressPercent = 3;

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
              maxValue: 3, // new
              value: progressPercent,
              minHeight: 50,
              borderWidth: 4,
              borderColor: Colors.yellow.shade900,
              borderStyle: BorderStyle.solid,
              colorLinearProgress: Colors.yellow,
              animationDuration: 1000,
              borderRadius: 20,
              linearProgressBarBorderRadius: 15,
              backgroundColor: Colors.green.shade50,
              progressAnimationCurve: Curves.ease, // new
              alignment: Alignment.center, // new
              showPercent: true, // new
              percentTextStyle: const TextStyle(fontWeight: FontWeight.bold),
              gradientColors: const [Colors.purple, Colors.blue, Colors.blueAccent], // new
              onProgressChanged: (double value) {
                // new
                // log('Progress: $value');
              },
            ),
            const SizedBox(height: 30),
            TextButton(
              onPressed: () {
                setState(() {
                  progressPercent += 0.5;
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
