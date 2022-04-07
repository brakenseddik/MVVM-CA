import 'dart:async';
import 'dart:io';
import 'dart:developer';

import 'package:mvvm/app/functions.dart';
import 'package:mvvm/domain/usecases/register_usecase.dart';
import 'package:mvvm/presentation/base/base_viewmodel.dart';
import 'package:mvvm/presentation/shared/freezed_dataclasses.dart';
import 'package:mvvm/presentation/shared/state_renderer/state_render_impl.dart';
import 'package:mvvm/presentation/shared/state_renderer/state_renderer.dart';

class RegisterViewModel extends BaseViewModel
    with RegisterViewModelInputs, RegisterViewModelOutputs {
  StreamController _userNameStreamController =
      StreamController<String>.broadcast();
  StreamController _mobileStreamController =
      StreamController<String>.broadcast();
  StreamController _emailStreamController =
      StreamController<String>.broadcast();
  StreamController _passwordStreamController =
      StreamController<String>.broadcast();
  StreamController _pictureStreamController =
      StreamController<File>.broadcast();
  StreamController _isAllInputsValidStreamController =
      StreamController<void>.broadcast();

  RegisterUseCase _registerUseCase;
  RegisterViewModel(this._registerUseCase);
  var registerObject = RegisterObject("", "", "", "", "", "");

//-- inputs

  @override
  Sink get inputEmail => _emailStreamController.sink;
  @override
  Sink get inputMobileNumber => _mobileStreamController.sink;

  @override
  Sink get inputPassword => _passwordStreamController.sink;

  @override
  Sink get inputPicture => _pictureStreamController.sink;

  @override
  Sink get inputUserName => _userNameStreamController.sink;

  @override
  Stream<bool> get outputIsUserNameValid => _userNameStreamController.stream
      .map((userName) => _validateUserName(userName));
  @override
  Stream<String?> get outputUserNameError => outputIsUserNameValid
      .map((isUsernameValid) => isUsernameValid ? null : "Invalid username");

  @override
  Stream<bool> get outputIsEmailValid =>
      _emailStreamController.stream.map((email) => isEmailValid(email));

  @override
  Stream<String?> get outputEmailError => outputIsEmailValid
      .map((emailValid) => emailValid ? null : "Invalid email");

  @override
  Stream<bool> get outputIsMobileValid => _mobileStreamController.stream
      .map((mobileNumber) => _validateMobileNumber(mobileNumber));

  @override
  Stream<String?> get outputMobileError => outputIsMobileValid
      .map((mobileValid) => mobileValid ? null : "Invalid mobile number");

  @override
  Stream<bool> get outputIsPasswordValid => _passwordStreamController.stream
      .map((password) => _validatePassword(password));
  @override
  Stream<String?> get outputPasswordError => outputIsPasswordValid
      .map((passValid) => passValid ? null : "Invalid password");

  @override
  Stream<File> get outputIsPictureValid =>
      _pictureStreamController.stream.map((file) => file);

  @override
  void dispose() {
    _userNameStreamController.close();
    _emailStreamController.close();
    _mobileStreamController.close();
    _pictureStreamController.close();
    _passwordStreamController.close();
    _isAllInputsValidStreamController.close();
    super.dispose();
  }

  @override
  register() async{
 inputState.add(
        LoadingState(stateRendererType: StateRendererType.POPUP_LOADING_STATE));
    (await _registerUseCase.execute(
            RegisterUseCaseInput(registerObject.email, registerObject.password, registerObject.name, registerObject.code, registerObject.mobile,registerObject.picture)))
        .fold(
            (failure) => {
                  // left -> failure
                  log(failure.message),
                  inputState.add(ErrorState(
                      StateRendererType.POPUP_ERROR_STATE, failure.message))
                },
            (data) => {
                  // right -> success (data)
                  log("success" + data.toString()),
                  inputState.add(ContentState()),
                  // navigate to main screen
                });  }

  @override
  void start() {
    inputState.add(ContentState());
  }

// private methods
  bool _validateUserName(String userName) {
    return userName.length >= 8;
  }

  bool _validateMobileNumber(String mobileNumber) {
    return mobileNumber.length == 10;
  }

  bool _validatePassword(String password) {
    return password.length > 8;
  }

  @override
  setCountryCode(String code) {
    if (code.isNotEmpty) {
      registerObject = registerObject.copyWith(code: code);
    } else {
      registerObject = registerObject.copyWith(code: "");
    }
    _validate();
  }

  @override
  setEmail(String email) {
    if (isEmailValid(email)) {
      registerObject = registerObject.copyWith(mobile: email);
    } else {
      registerObject = registerObject.copyWith(email: "");
    }
    _validate();
  }

  @override
  setMobileNumber(String mobile) {
    if (_validateMobileNumber(mobile)) {
      registerObject = registerObject.copyWith(mobile: mobile);
    } else {
      registerObject = registerObject.copyWith(mobile: "");
    }
    _validate();
  }

  @override
  setPassword(String password) {
    if (_validatePassword(password)) {
      registerObject = registerObject.copyWith(password: password);
    } else {
      registerObject = registerObject.copyWith(password: "");
    }
    _validate();
  }

  @override
  setPicture(File image) {
    if (image.path.isNotEmpty) {
      registerObject = registerObject.copyWith(picture: image.path);
    } else {
      registerObject = registerObject.copyWith(picture: "");
    }
    _validate();
  }

  @override
  setUserName(String name) {
    if (_validateUserName(name)) {
      registerObject = registerObject.copyWith(name: name);
    } else {
      registerObject = registerObject.copyWith(name: "");
    }
    _validate();
  }

  @override
  Sink get inputAllInputsValid => _isAllInputsValidStreamController.sink;

  @override
  Stream<bool> get outputIsAllInputsValid =>
      _isAllInputsValidStreamController.stream
          .map((event) => _validateAllInputs());

  bool _validateAllInputs() {
    return registerObject.picture.isNotEmpty &&
        registerObject.password.isNotEmpty &&
        registerObject.name.isNotEmpty &&
        registerObject.email.isNotEmpty &&
        registerObject.mobile.isNotEmpty &&
        registerObject.code.isNotEmpty;
  }

  _validate() {
    inputAllInputsValid.add(null);
  }
}

abstract class RegisterViewModelInputs {
  setUserName(String name);
  setEmail(String email);
  setMobileNumber(String mobile);
  setPassword(String password);
  setCountryCode(String code);
  setPicture(File image);

  Sink get inputEmail;
  Sink get inputMobileNumber;
  Sink get inputPassword;
  Sink get inputPicture;
  Sink get inputUserName;
  Sink get inputAllInputsValid;
  register();
}

abstract class RegisterViewModelOutputs {
  Stream<String?> get outputEmailError;
  Stream<bool> get outputIsEmailValid;

  Stream<bool> get outputIsMobileValid;
  Stream<bool> get outputIsPasswordValid;

  Stream<File> get outputIsPictureValid;
  Stream<bool> get outputIsUserNameValid;

  Stream<String?> get outputMobileError;
  Stream<String?> get outputPasswordError;

  Stream<String?> get outputUserNameError;

  Stream<bool> get outputIsAllInputsValid;
}
