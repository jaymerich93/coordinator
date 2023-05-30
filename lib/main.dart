import 'package:coordinator/widget1.dart';
import 'package:coordinator/widget2.dart';
import 'package:coordinator/widget3.dart';
import 'package:flutter/material.dart';

import 'load_animation_controller.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        mainAxisSize: MainAxisSize.max,
        children: [
          Column(
            children: const [
              Widget1(),
              SizedBox(height: 16),
              Widget2(),
              SizedBox(height: 16),
              Widget3(),
            ],
          ),
          const SizedBox(width: 16),
          LoadAnimationController(
            child: Column(
              children: const [
                Widget1(),
                SizedBox(height: 16),
                Widget2(),
                SizedBox(height: 16),
                Widget3(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
