import 'dart:async';
import 'dart:developer';

import 'package:mvvm/domain/usecases/login_usecase.dart';
import 'package:mvvm/presentation/base/base_viewmodel.dart';
import 'package:mvvm/presentation/shared/freezed_dataclasses.dart';

class LoginViewModel extends BaseViewModel
    with LoginViewModelInputs, LoginViewModelOutputs {
  StreamController _userNameStreamController =
      StreamController<String>.broadcast();
  StreamController _passwordStreamController =
      StreamController<String>.broadcast();

  StreamController _isAllInputsValidStreamController =
      StreamController<void>.broadcast();

  var loginObject = LoginObject("", "");

  LoginUseCase _loginUseCase; // todo remove ?

  LoginViewModel(this._loginUseCase);

  // inputs

  @override
  Sink get inputIsAllInputValid => _isAllInputsValidStreamController.sink;

  @override
  Sink get inputPassword => _passwordStreamController.sink;

  @override
  Sink get inputUserName => _userNameStreamController.sink;

  @override
  Stream<bool> get outputIsAllInputsValid =>
      _isAllInputsValidStreamController.stream.map((_) => _isAllInputsValid());

  @override
  Stream<bool> get outputIsPasswordValid => _passwordStreamController.stream
      .map((password) => _isPasswordValid(password));

  @override
  Stream<bool> get outputIsUserNameValid => _userNameStreamController.stream
      .map((userName) => _isUserNameValid(userName));

  // outputs
  @override
  void dispose() {
    _userNameStreamController.close();
    _isAllInputsValidStreamController.close();
    _passwordStreamController.close();
  }

  @override
  login() async {
    (await _loginUseCase.execute(LoginUseCaseInput(
            email: loginObject.userName, password: loginObject.password)))
        .fold(
            (failure) => {
                  // left -> failure
                  log(failure.message.toString())
                },
            (data) => {
                  // right -> success (data)
                  log(data.customer!.name)
                });
  }

  @override
  setPassword(String password) {
    inputPassword.add(password);
    loginObject = loginObject.copyWith(
        password: password); // data class operation same as kotlin
    _validate();
  }

  // private functions

  @override
  setUserName(String userName) {
    inputUserName.add(userName);
    loginObject = loginObject.copyWith(
        userName: userName); // data class operation same as kotlin
    _validate();
  }

  @override
  void start() {
    // TODO: implement start
  }

  bool _isAllInputsValid() {
    return _isPasswordValid(loginObject.password) &&
        _isUserNameValid(loginObject.userName);
  }

  bool _isPasswordValid(String password) {
    return password.isNotEmpty;
  }

  bool _isUserNameValid(String userName) {
    return userName.isNotEmpty;
  }

  _validate() {
    inputIsAllInputValid.add(null);
  }
}

abstract class LoginViewModelInputs {
  // three functions for actions
  Sink get inputIsAllInputValid;

  Sink get inputPassword;

  Sink get inputUserName;

// two sinks for streams
  login();

  setPassword(String password);

  setUserName(String userName);
}

abstract class LoginViewModelOutputs {
  Stream<bool> get outputIsAllInputsValid;

  Stream<bool> get outputIsPasswordValid;

  Stream<bool> get outputIsUserNameValid;
}
