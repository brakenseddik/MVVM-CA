import 'dart:async';

import 'package:mvvm/presentation/shared/state_renderer/state_render_impl.dart';
import 'package:rxdart/subjects.dart';

abstract class BaseViewModel extends BaseViewModelInputs
    with BaseViewModelOutputs {
  StreamController _inputStateStreamController = BehaviorSubject<FlowState>();

  @override
  Sink get inputState => _inputStateStreamController.sink;
  @override
  Stream<FlowState> get outputState =>
      _inputStateStreamController.stream.map((flowState) => flowState);

  @override
  void dispose() {
    _inputStateStreamController.close();
  }
}

abstract class BaseViewModelInputs {
  Sink get inputState;
  void dispose();
  void start();
}

abstract class BaseViewModelOutputs {
  Stream<FlowState> get outputState;
}
