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

  _selectedData(BuildContext context) async {
    final DateTime? piked = await showDatePicker(
      context: context,
      initialDate: selectedData,
      firstDate: DateTime(1950),
      lastDate: DateTime(2028),
    );
    if (piked != null && piked != selectedData) {
      setState(() {
        selectedData = piked;
      });
    }
  }

  late double progressPercent = 0;
  final double total = 1200;

  double users = 1100;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.ac_unit_rounded)),
          PopupMenuButton(
            itemBuilder: (context) {
              return [
                const PopupMenuItem(child: Text("Hello")),
                const PopupMenuItem(child: Text("World")),
                const PopupMenuItem(child: Text("!")),
              ];
            },
          )
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomLinearProgressIndicator(
              borderColor: Colors.blue,
              borderWidth: 3,
              progressPercent:
                  double.tryParse((users / total).toStringAsFixed(2))!,
              width: 0.8,
              colorLinearProgress: Colors.black87,
              animationDurationSeconds: 2,
              minHeight: 50,
              linearProgressBarBorderRadius: 12.0,
              borderRadius: 12.0,
              backgroundColor: Colors.green.shade50,
              percentTextStyle: const TextStyle(
                color: Colors.blue,
                fontSize: 20,
                fontWeight: FontWeight.w800,
              ),
            ),
            const SizedBox(height: 30),
            const CustomLinearProgressIndicator(progressPercent: 0.6),
            const SizedBox(height: 30),
            const CustomLinearProgressIndicator(
              progressPercent: 0.75,
              colorLinearProgress: Colors.green,
              backgroundColor: Colors.black12,
              borderRadius: 20.0,
              linearProgressBarBorderRadius: 20.0,
              minHeight: 65,
              width: 0.8,
              percentTextStyle: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.w800,
              ),
            )
          ],
        ),
      ),

      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
