import 'package:coordinator/load_animation_controller.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Widget3 extends StatefulWidget {
  const Widget3({super.key});

  @override
  State<Widget3> createState() => _Widget3State();
}

class _Widget3State extends State<Widget3> {
  late Widget3ViewModel _viewModel;

  @override
  void initState() {
    _viewModel = Widget3ViewModel(
      loadAnimationNotifier: context.read<LoadAnimationNotifier?>(),
    );

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<Widget3ViewModel>(
      create: (_) => _viewModel,
      builder: (context, _) {
        final hasData = context.select<Widget3ViewModel, bool>(
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

class Widget3ViewModel extends ViewModel {
  Widget3ViewModel({super.loadAnimationNotifier}) {
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
