import 'package:coordinator/pages/animation_coordinator/animation_coordinator_page.dart';
import 'package:coordinator/pages/image_network_coordinator/image_network_coordinator_page.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: const [
        _AnimationCoordinatorButton(),
        SizedBox(height: 16),
        _ImageNetworkCoordinatorButton(),
      ],
    );
  }
}

class _AnimationCoordinatorButton extends StatelessWidget {
  const _AnimationCoordinatorButton();

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      child: const Text('Animation coordinator'),
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => const AnimationCoordinatorPage(),
          ),
        );
      },
    );
  }
}

class _ImageNetworkCoordinatorButton extends StatelessWidget {
  const _ImageNetworkCoordinatorButton();

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      child: const Text('Image network coordinator'),
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => const ImageNetworkCoordinatorPage(),
          ),
        );
      },
    );
  }
}
