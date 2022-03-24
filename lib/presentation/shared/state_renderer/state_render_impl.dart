import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mvvm/data/mappers/mapper.dart';
import 'package:mvvm/presentation/resources/strings_manager.dart';
import 'package:mvvm/presentation/shared/state_renderer/state_renderer.dart';

class ContentState extends FlowState {
  ContentState();
  @override
  String getMessage() => EMPTY;

  @override
  StateRendererType getStateRendererType() =>
      StateRendererType.CONTENT_SCREEN_STATE;
}

class EmptyState extends FlowState {
  String message;
  EmptyState(
    this.message,
  );
  @override
  String getMessage() => message;

  @override
  StateRendererType getStateRendererType() =>
      StateRendererType.EMPTY_SCREEN_STATE;
}

class ErrorState extends FlowState {
  StateRendererType stateRendererType;
  String message;
  ErrorState(
    this.stateRendererType,
    this.message,
  );
  @override
  String getMessage() => message;

  @override
  StateRendererType getStateRendererType() => stateRendererType;
}

abstract class FlowState {
  String getMessage();
  StateRendererType getStateRendererType();
}

class LoadingState extends FlowState {
  StateRendererType stateRendererType;
  String message;
  LoadingState({
    required this.stateRendererType,
    String? message,
  }) : message = message ?? AppStrings.loading;
  @override
  String getMessage() => message;

  @override
  StateRendererType getStateRendererType() => stateRendererType;
}

extension FlowStateExtension on FlowState {
  Widget getScreenWidget(BuildContext context, Widget screenContent,
      Function retryActionFunction) {
    switch (this.runtimeType) {
      case LoadingState:
        {
          if (getStateRendererType() ==
              StateRendererType.POPUP_LOADING_STATE) {
            showPopUp(context, getStateRendererType(), getMessage());
            return screenContent;
          } else {
            return StateRenderer(
              stateRendererType: getStateRendererType(),
              retryAction: retryActionFunction,
              message: getMessage(),
            );
          }
        }
      case ErrorState:
        {
          dismissDialog(context);
          if (getStateRendererType() ==
              StateRendererType.POPUP_ERROR_STATE) {
            showPopUp(context, getStateRendererType(), getMessage());
            return screenContent;
          } else {
            return StateRenderer(
              stateRendererType: getStateRendererType(),
              retryAction: retryActionFunction,
              message: getMessage(),
            );
          }
        }
      case EmptyState:
        {
          return StateRenderer(
            stateRendererType: getStateRendererType(),
            retryAction: retryActionFunction,
            message: getMessage(),
          );
        }
      case ContentState:
        {
          dismissDialog(context);
          return screenContent;
        }

      default:
        {
          return screenContent;
        }
    }
  }

   dismissDialog(BuildContext context) {
    if (_isThereCurrentDialogShowing(context)) {
      Navigator.of(context, rootNavigator: true).pop(true);
    }
  }

  _isThereCurrentDialogShowing(BuildContext context) =>
      ModalRoute.of(context)?.isCurrent != true;

  showPopUp(
      BuildContext context, StateRendererType stateRenderType, String message) {
    WidgetsBinding.instance?.addPostFrameCallback((timeStamp) => showDialog(
        context: context,
        builder: (context) {
          return StateRenderer(
            stateRendererType: stateRenderType,
            retryAction: () {},
            message: message,
          );
        }));
  }
}
