import 'package:coordinator/pages/animation_coordinator/widgets/load_animation_controller.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Widget2 extends StatefulWidget {
  const Widget2({super.key});

  @override
  State<Widget2> createState() => _Widget2State();
}

class _Widget2State extends State<Widget2> {
  late Widget2ViewModel _viewModel;

  @override
  void initState() {
    _viewModel = Widget2ViewModel(
      loadAnimationController: context.read<LoadAnimationNotifier?>(),
    );

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<Widget2ViewModel>(
      create: (_) => _viewModel,
      builder: (context, _) {
        bool? hasData = context.select<LoadAnimationNotifier?, bool?>(
          (w) => w?.hasData,
        );

        hasData ??= context.select<Widget2ViewModel, bool>(
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

class Widget2ViewModel extends ChangeNotifier {
  Widget2ViewModel({
    LoadAnimationNotifier? loadAnimationController,
  }) {
    loadAnimationController?.add(this, hasData);

    Future.microtask(_fetchData);
  }

  List<int>? data;

  Future<void> _fetchData() async {
    await Future.delayed(const Duration(seconds: 2));
    data = [];

    notifyListeners();
  }

  bool hasData() {
    return data != null;
  }
}
