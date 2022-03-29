import 'dart:async';
import 'dart:developer';

import 'package:mvvm/domain/usecases/forgot_usecase.dart';
import 'package:mvvm/presentation/base/base_viewmodel.dart';
import 'package:mvvm/presentation/shared/state_renderer/state_render_impl.dart';
import 'package:mvvm/presentation/shared/state_renderer/state_renderer.dart';

class ForgotPassViewModel extends BaseViewModel
    with ForgotPassViewModelInputs, ForgotPassViewModelOutputs {
  StreamController _userInputStreamController =
      StreamController<String>.broadcast();

  ForgotUseCase _forgotUseCase;

  String email = "";
  ForgotPassViewModel(this._forgotUseCase);
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
  forgot() async {
    inputState.add(
        LoadingState(stateRendererType: StateRendererType.POPUP_LOADING_STATE));
    (await _forgotUseCase.execute(ForgotUseCaseInput(email))).fold(
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
            });
  }

  @override
  setUserName(String userName) {
    inputUserName.add(userName);
    email = userName;
  }

  @override
  void start() {
        inputState.add(ContentState());

  }

  bool _isUserNameValid(String userName) {
    return userName.isNotEmpty;
  }
}

abstract class ForgotPassViewModelInputs {
  Sink get inputUserName;
  forgot();
  setUserName(String userName);
}

abstract class ForgotPassViewModelOutputs {
  Stream<bool> get isOutputIsUserNameValid;
}
