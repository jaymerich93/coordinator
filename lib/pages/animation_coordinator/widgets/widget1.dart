import 'package:coordinator/pages/animation_coordinator/widgets/load_animation_controller.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Widget1 extends StatefulWidget {
  const Widget1({
    super.key,
  });

  @override
  State<Widget1> createState() => _Widget1State();
}

class _Widget1State extends State<Widget1> {
  late Widget1ViewModel _viewModel;

  @override
  void initState() {
    _viewModel = Widget1ViewModel(
      loadAnimationController: context.read<LoadAnimationNotifier?>(),
    );

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<Widget1ViewModel>(
      create: (_) => _viewModel,
      builder: (context, _) {
        bool? hasData = context.select<LoadAnimationNotifier?, bool?>(
          (w) => w?.hasData,
        );

        hasData ??= context.select<Widget1ViewModel, bool>(
          (w) => w.hasData(),
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

class Widget1ViewModel extends ChangeNotifier {
  Widget1ViewModel({
    LoadAnimationNotifier? loadAnimationController,
  }) {
    loadAnimationController?.add(this, hasData);

    Future.microtask(_fetchData);
  }

  List<int>? data;

  Future<void> _fetchData() async {
    await Future.delayed(const Duration(seconds: 5));
    data = [];

    notifyListeners();
  }

  bool hasData() {
    return data != null;
  }
}
