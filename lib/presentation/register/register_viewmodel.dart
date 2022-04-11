import 'dart:async';
import 'dart:io';

import 'package:mvvm/app/functions.dart';
import 'package:mvvm/domain/usecases/register_usecase.dart';
import 'package:mvvm/presentation/base/base_viewmodel.dart';
import 'package:mvvm/presentation/shared/freezed_dataclasses.dart';
import 'package:mvvm/presentation/shared/state_renderer/state_render_impl.dart';
import 'package:mvvm/presentation/shared/state_renderer/state_renderer.dart';

class RegisterViewModel extends BaseViewModel
    with RegisterViewModelInput, RegisterViewModelOutput {
  StreamController _userNameStreamController =
      StreamController<String>.broadcast();
  StreamController _mobileNumberStreamController =
      StreamController<String>.broadcast();

  StreamController _emailStreamController =
      StreamController<String>.broadcast();

  StreamController _passwordStreamController =
      StreamController<String>.broadcast();

  StreamController _profilePictureStreamController =
      StreamController<File>.broadcast();

  StreamController _isAllInputsValidStreamController =
      StreamController<void>.broadcast();
  StreamController isUserLoggedInSuccessfully = StreamController<bool>();

  RegisterUseCase _registerUseCase;

  var registerViewObject = RegisterObject("", "", "", "", "", "");

  RegisterViewModel(this._registerUseCase);

  //  -- inputs
  @override
  Sink get inputAllInputsValid => _isAllInputsValidStreamController.sink;

  @override
  Sink get inputEmail => _emailStreamController.sink;

  @override
  Sink get inputMobileNumber => _mobileNumberStreamController.sink;

  @override
  Sink get inputProfilePicture => _profilePictureStreamController.sink;

  @override
  Sink get inputUPassword => _passwordStreamController.sink;

  @override
  Sink get inputUserName => _userNameStreamController.sink;

  @override
  Stream<String?> get outputErrorEmail => outputIsEmailValid
      .map((isEmailValid) => isEmailValid ? null : "Invalid Email");

  @override
  Stream<String?> get outputErrorMobileNumber =>
      outputIsMobileNumberValid.map((isMobileNumberValid) =>
          isMobileNumberValid ? null : "Invalid Mobile Number");

  @override
  Stream<String?> get outputErrorPassword => outputIsPasswordValid
      .map((isPasswordValid) => isPasswordValid ? null : "Invalid Password");

  @override
  Stream<String?> get outputErrorUserName => outputIsUserNameValid
      .map((isUserNameValid) => isUserNameValid ? null : "Invalid username");

  @override
  Stream<bool> get outputIsAllInputsValid =>
      _isAllInputsValidStreamController.stream.map((_) => _validateAllInputs());

  @override
  Stream<bool> get outputIsEmailValid =>
      _emailStreamController.stream.map((email) => isEmailValid(email));

  @override
  Stream<bool> get outputIsMobileNumberValid =>
      _mobileNumberStreamController.stream
          .map((mobileNumber) => _isMobileNumberValid(mobileNumber));

  @override
  Stream<bool> get outputIsPasswordValid => _passwordStreamController.stream
      .map((password) => _isPasswordValid(password));

  @override
  Stream<bool> get outputIsUserNameValid => _userNameStreamController.stream
      .map((userName) => _isUserNameValid(userName));

  // -- outputs

  @override
  Stream<File?> get outputProfilePicture =>
      _profilePictureStreamController.stream.map((file) => file);

  @override
  void dispose() {
    _isAllInputsValidStreamController.close();
    _userNameStreamController.close();
    _mobileNumberStreamController.close();
    _emailStreamController.close();
    _passwordStreamController.close();
    _profilePictureStreamController.close();
    isUserLoggedInSuccessfully.close();
    super.dispose();
  }

  @override
  register() async {
    inputState.add(
        LoadingState(stateRendererType: StateRendererType.POPUP_LOADING_STATE));
    (await _registerUseCase.execute(RegisterUseCaseInput(
      registerViewObject.email,
      registerViewObject.password,
      registerViewObject.name,
      registerViewObject.code,
      registerViewObject.mobile,
      registerViewObject.picture,
    )))
        .fold(
            (failure) => {
                  // left -> failure
                  inputState.add(ErrorState(
                      StateRendererType.POPUP_ERROR_STATE, failure.message))
                }, (data) {
      // right -> success (data)
      inputState.add(ContentState());

      // navigate to main screen after the register
      isUserLoggedInSuccessfully.add(true);
    });
  }

  @override
  setCountryCode(String countryCode) {
    if (countryCode.isNotEmpty) {
      // update register view object with countryCode value
      registerViewObject = registerViewObject.copyWith(
          code: countryCode); // using data class like kotlin
    } else {
      // reset countryCode value in register view object
      registerViewObject = registerViewObject.copyWith(code: "");
    }
    _validate();
  }

  @override
  setEmail(String email) {
    inputEmail.add(email);
    if (isEmailValid(email)) {
      // update register view object with email value
      registerViewObject = registerViewObject.copyWith(
          email: email); // using data class like kotlin
    } else {
      // reset email value in register view object
      registerViewObject = registerViewObject.copyWith(email: "");
    }
    _validate();
  }

  @override
  setMobileNumber(String mobileNumber) {
    inputMobileNumber.add(mobileNumber);
    if (_isMobileNumberValid(mobileNumber)) {
      // update register view object with mobileNumber value
      registerViewObject = registerViewObject.copyWith(
          mobile: mobileNumber); // using data class like kotlin
    } else {
      // reset mobileNumber value in register view object
      registerViewObject = registerViewObject.copyWith(mobile: "");
    }
    _validate();
  }

  @override
  setPassword(String password) {
    inputUPassword.add(password);
    if (_isPasswordValid(password)) {
      // update register view object with password value
      registerViewObject = registerViewObject.copyWith(
          password: password); // using data class like kotlin
    } else {
      // reset password value in register view object
      registerViewObject = registerViewObject.copyWith(password: "");
    }
    _validate();
  }

  @override
  setProfilePicture(File file) {
    inputProfilePicture.add(file);
    if (file.path.isNotEmpty) {
      // update register view object with profilePicture value
      registerViewObject = registerViewObject.copyWith(
          picture: file.path); // using data class like kotlin
    } else {
      // reset profilePicture value in register view object
      registerViewObject = registerViewObject.copyWith(picture: "");
    }
    _validate();
  }

  @override
  setUserName(String userName) {
    inputUserName.add(userName);
    if (_isUserNameValid(userName)) {
      // update register view object with username value
      registerViewObject = registerViewObject.copyWith(
          name: userName); // using data class like kotlin
    } else {
      // reset username value in register view object
      registerViewObject = registerViewObject.copyWith(name: "");
    }
    _validate();
  }

  @override
  void start() {
    // view tells state renderer, please show the content of the screen
    inputState.add(ContentState());
  }

  // -- private methods
  bool _isMobileNumberValid(String mobileNumber) {
    return mobileNumber.length >= 10;
  }

  bool _isPasswordValid(String password) {
    return password.length >= 8;
  }

  bool _isUserNameValid(String userName) {
    return userName.length >= 8;
  }

  _validate() {
    inputAllInputsValid.add(null);
  }

  bool _validateAllInputs() {
    return registerViewObject.picture.isNotEmpty &&
        registerViewObject.email.isNotEmpty &&
        registerViewObject.password.isNotEmpty &&
        registerViewObject.mobile.isNotEmpty &&
        registerViewObject.name.isNotEmpty &&
        registerViewObject.code.isNotEmpty;
  }
}

abstract class RegisterViewModelInput {
  Sink get inputAllInputsValid;

  Sink get inputEmail;

  Sink get inputMobileNumber;

  Sink get inputProfilePicture;

  Sink get inputUPassword;

  Sink get inputUserName;

  register();

  setCountryCode(String countryCode);

  setEmail(String email);

  setMobileNumber(String mobileNumber);

  setPassword(String password);

  setProfilePicture(File file);

  setUserName(String userName);
}

abstract class RegisterViewModelOutput {
  Stream<String?> get outputErrorEmail;

  Stream<String?> get outputErrorMobileNumber;

  Stream<String?> get outputErrorPassword;

  Stream<String?> get outputErrorUserName;

  Stream<bool> get outputIsAllInputsValid;

  Stream<bool> get outputIsEmailValid;

  Stream<bool> get outputIsMobileNumberValid;

  Stream<bool> get outputIsPasswordValid;

  Stream<bool> get outputIsUserNameValid;

  Stream<File?> get outputProfilePicture;
}
