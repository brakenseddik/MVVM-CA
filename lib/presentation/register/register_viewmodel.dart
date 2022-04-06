import 'dart:async';
import 'dart:io';

import 'package:mvvm/app/functions.dart';
import 'package:mvvm/domain/usecases/register_usecase.dart';
import 'package:mvvm/presentation/base/base_viewmodel.dart';

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
  Stream<File> get outputIsPictureValid => _pictureStreamController.stream.map((file) => file);

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
  register() {
    // TODO: implement register
    throw UnimplementedError();
  }

  @override
  void start() {
    // TODO: implement start
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
}

abstract class RegisterViewModelInputs {
  Sink get inputEmail;
  Sink get inputMobileNumber;
  Sink get inputPassword;
  Sink get inputPicture;
  Sink get inputUserName;
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
}
