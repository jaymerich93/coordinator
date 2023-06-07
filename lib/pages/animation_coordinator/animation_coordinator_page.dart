import 'package:coordinator/pages/animation_coordinator/widgets/load_animation_controller.dart';
import 'package:coordinator/pages/animation_coordinator/widgets/widget1.dart';
import 'package:coordinator/pages/animation_coordinator/widgets/widget2.dart';
import 'package:coordinator/pages/animation_coordinator/widgets/widget3.dart';
import 'package:flutter/material.dart';

import 'widgets/widget4.dart';

class AnimationCoordinatorPage extends StatelessWidget {
  const AnimationCoordinatorPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Animation coordinator'),
      ),
      body: ListView(
        children: [
          Row(
            children: [
              Column(
                children: const [
                  Widget1(),
                  SizedBox(height: 16),
                  Widget2(),
                  SizedBox(height: 16),
                  Widget3(),
                  SizedBox(height: 16),
                  Widget4(),
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
                    SizedBox(height: 16),
                    Widget4(),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
