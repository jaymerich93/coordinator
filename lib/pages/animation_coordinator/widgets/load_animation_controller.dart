import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoadAnimationController extends StatelessWidget {
  const LoadAnimationController({
    super.key,
    required this.child,
  });

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<LoadAnimationNotifier>(
      create: (_) => LoadAnimationNotifier(),
      child: child,
    );
  }
}

class LoadAnimationNotifier extends ChangeNotifier {
  bool _hasData = false;
  bool get hasData => _hasData;

  final _suscriptions = <ChangeNotifier>[];
  final _conditions = <bool Function()>[];

  @override
  void dispose() {
    for (var suscription in _suscriptions) {
      suscription.removeListener(_onUpdateModelView);
    }

    super.dispose();
  }

  void add(ChangeNotifier modelView, bool Function() condition) {
    _conditions.add(condition);
    _suscriptions.add(modelView);
    modelView.addListener(_onUpdateModelView);
  }

  void addFromMixin(AnimationCoordinatorMixin animationCoordinatorMixin) {
    _conditions.add(animationCoordinatorMixin.checkHasData);
    _suscriptions.add(animationCoordinatorMixin);
    animationCoordinatorMixin.addListener(_onUpdateModelView);
  }

  void remove(ChangeNotifier modelView, bool Function() condition) {
    _conditions.remove(condition);
    _suscriptions.remove(modelView);
    modelView.removeListener(_onUpdateModelView);
  }

  void removeFromMixin(AnimationCoordinatorMixin animationCoordinatorMixin) {
    _conditions.remove(animationCoordinatorMixin.checkHasData);
    _suscriptions.remove(animationCoordinatorMixin);
    animationCoordinatorMixin.removeListener(_onUpdateModelView);
  }

  void _onUpdateModelView() {
    _evaluateConditions();
  }

  void _evaluateConditions() {
    final conditionsToEvaluate = _conditions.toList();
    for (final condition in conditionsToEvaluate) {
      final newHasData = condition();
      if (!newHasData) {
        if (newHasData != _hasData) {
          _hasData = false;
          notifyListeners();
        }

        return;
      }
    }

    if (!_hasData) {
      _hasData = true;
      notifyListeners();
    }
  }
}

abstract class ViewModel extends ChangeNotifier {
  ViewModel({
    this.loadAnimationNotifier,
  }) {
    loadAnimationNotifier?.add(this, checkHasData);
    loadAnimationNotifier?.addListener(_propagateNotifyListeners);
  }

  @override
  void dispose() {
    loadAnimationNotifier?.remove(this, checkHasData);
    loadAnimationNotifier?.removeListener(_propagateNotifyListeners);

    super.dispose();
  }

  LoadAnimationNotifier? loadAnimationNotifier;

  bool get hasData => _internalHasData();

  bool checkHasData();

  bool _internalHasData() {
    return loadAnimationNotifier?.hasData ?? checkHasData();
  }

  void _propagateNotifyListeners() {
    notifyListeners();
  }
}

mixin AnimationCoordinatorMixin on ChangeNotifier {
  LoadAnimationNotifier? _loadAnimationNotifier;

  bool get hasData => _internalHasData();

  @override
  void dispose() {
    _unscribeToAnimationCoordinator();
    super.dispose();
  }

  bool checkHasData();

  void suscribeToAnimationCoordinator(
    LoadAnimationNotifier? loadAnimationNotifier,
  ) {
    _unscribeToAnimationCoordinator();

    _loadAnimationNotifier = loadAnimationNotifier;
    _loadAnimationNotifier?.addFromMixin(this);
    _loadAnimationNotifier?.addListener(_propagateNotifyListeners);
  }

  void _unscribeToAnimationCoordinator() {
    _loadAnimationNotifier?.removeFromMixin(this);
    _loadAnimationNotifier?.removeListener(_propagateNotifyListeners);
  }

  bool _internalHasData() {
    return _loadAnimationNotifier?.hasData ?? checkHasData();
  }

  void _propagateNotifyListeners() {
    notifyListeners();
  }
}
