import 'dart:async';

import 'package:mvvm/presentation/base/base_viewmodel.dart';

class ForgotPassViewModel extends BaseViewModel
    with ForgotPassViewModelInputs, ForgotPassViewModelOutputs {


  StreamController _userInputStreamController =
      StreamController<String>.broadcast();



  @override
  Sink get inputUserName => _userInputStreamController.sink;

  @override
  Stream<bool> get isOutputIsUserNameValid => _userInputStreamController.stream
      .map((userName) => _isUserNameValid(userName));

  @override
  void dispose() {
    _userInputStreamController.close();
  }

  @override
  send() {}

  @override
  setUserName(String userName) {
    inputUserName.add(userName);
  }

  @override
  void start() {}

  bool _isUserNameValid(String userName) {
    return userName.isNotEmpty;
  }
}

abstract class ForgotPassViewModelInputs {
  Sink get inputUserName;
  send();
  setUserName(String userName);
}

abstract class ForgotPassViewModelOutputs {
  Stream<bool> get isOutputIsUserNameValid;
}
