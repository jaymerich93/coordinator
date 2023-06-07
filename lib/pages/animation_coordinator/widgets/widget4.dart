import 'package:coordinator/pages/animation_coordinator/widgets/load_animation_controller.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Widget4 extends StatefulWidget {
  const Widget4({super.key});

  @override
  State<Widget4> createState() => _Widget4State();
}

class _Widget4State extends State<Widget4> {
  late Widget4ViewModel _viewModel;

  @override
  void initState() {
    _viewModel = Widget4ViewModel(
      loadAnimationNotifier: context.read<LoadAnimationNotifier?>(),
    );

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<Widget4ViewModel>(
      create: (_) => _viewModel,
      builder: (context, _) {
        final hasData = context.select<Widget4ViewModel, bool>(
          (w) => w.hasData,
        );

        return Container(
          height: 200,
          width: 200,
          color: !hasData ? Colors.orangeAccent[200] : Colors.blue[200],
        );
      },
    );
  }
}

class Widget4ViewModel extends ChangeNotifier with AnimationCoordinatorMixin {
  Widget4ViewModel({
    LoadAnimationNotifier? loadAnimationNotifier,
  }) {
    suscribeToAnimationCoordinator(loadAnimationNotifier);
    Future.microtask(_fetchData);
  }

  List<int>? data;

  Future<void> _fetchData() async {
    await Future.delayed(const Duration(seconds: 1));
    data = [];

    notifyListeners();
  }

  @override
  bool checkHasData() {
    return data != null;
  }
}
