import 'dart:async';
import 'dart:developer';

import 'package:mvvm/domain/usecases/login_usecase.dart';
import 'package:mvvm/presentation/base/base_viewmodel.dart';
import 'package:mvvm/presentation/shared/freezed_dataclasses.dart';
import 'package:mvvm/presentation/shared/state_renderer/state_render_impl.dart';
import 'package:mvvm/presentation/shared/state_renderer/state_renderer.dart';

class LoginViewModel extends BaseViewModel
    with LoginViewModelInputs, LoginViewModelOutputs {
  StreamController _userNameStreamController =
      StreamController<String>.broadcast();
  StreamController _passwordStreamController =
      StreamController<String>.broadcast();

  StreamController _isAllInputsValidStreamController =
      StreamController<void>.broadcast();

  var loginObject = LoginObject("", "");

  LoginUseCase _loginUseCase;

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

  @override
  void dispose() {
    _userNameStreamController.close();
    _isAllInputsValidStreamController.close();
    _passwordStreamController.close();
  }

  @override
  login() async {
    inputState.add(
        LoadingState(stateRendererType: StateRendererType.POPUP_LOADING_STATE));
    (await _loginUseCase.execute(
            LoginUseCaseInput(loginObject.userName, loginObject.password)))
        .fold(
            (failure) => {
                  // left -> failure
                  log(failure.message),
                  inputState.add(ErrorState(
                      StateRendererType.POPUP_ERROR_STATE, failure.message))
                },
            (data) => {
                  // right -> success (data)
                  log(data.toString()),
                  inputState.add(ContentState()),
                  // navigate to main screen
                });
  }

  // outputs
  @override
  setPassword(String password) {
    inputPassword.add(password);
    loginObject = loginObject.copyWith(
        password: password); // data class operation same as kotlin
    _validate();
  }

  @override
  setUserName(String userName) {
    inputUserName.add(userName);
    loginObject = loginObject.copyWith(
        userName: userName); // data class operation same as kotlin
    _validate();
  }

  @override
  void start() {
    inputState.add(ContentState());
  }

  // private functions

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
