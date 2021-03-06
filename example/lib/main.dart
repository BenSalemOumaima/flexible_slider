import 'package:flexible_slider/arrays.dart';
import 'package:flexible_slider/flexible_slider.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flexible Slider'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Horizontal with default orientation'),
              const SizedBox(
                height: 20,
              ),
              FlexibleSlider(
                divisions: 4,
                onValueChanged: (value) {
                  print(value);
                },
              ),
              const SizedBox(
                height: 20,
              ),
              const Text('Horizontal with reversed orientation'),
              const SizedBox(
                height: 20,
              ),
              FlexibleSlider(
                divisions: 5,
                position: Position.reversedPosition,
                onValueChanged: (value) {
                  print(value);
                },
              ),
              const SizedBox(
                height: 20,
              ),
              const Text('Vertical with default orientation'),
              const SizedBox(
                height: 20,
              ),
              FlexibleSlider(
                divisions: 5,
                direction: Direction.vertical,
                onValueChanged: (value) {
                  print(value);
                },
              ),
              const SizedBox(
                height: 20,
              ),
              const Text('Vertical with reversed orientation'),
              const SizedBox(
                height: 20,
              ),
              FlexibleSlider(
                divisions: 5,
                direction: Direction.vertical,
                position: Position.reversedPosition,
                fractionDigits: 6,
                onValueChanged: (value) {
                  print(value);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
