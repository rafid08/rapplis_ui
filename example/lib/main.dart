import 'package:flutter/material.dart';
import 'package:rapplis_ui/rapplis_ui.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Rapplis UI',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Rapplis UI'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

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
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            JumpingButton(
              onTap: () {},
              scale: 0.9,
              haptic: true,
              child: Container(
                color: Colors.red,
                padding: const EdgeInsets.all(10),
                child: const Text(
                  "Hello",
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
