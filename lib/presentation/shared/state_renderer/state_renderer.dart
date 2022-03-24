import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:mvvm/data/mappers/mapper.dart';
import 'package:mvvm/data/network/failure.dart';
import 'package:mvvm/presentation/resources/assets_manager.dart';
import 'package:mvvm/presentation/resources/color_manager.dart';
import 'package:mvvm/presentation/resources/strings_manager.dart';
import 'package:mvvm/presentation/resources/style_manager.dart';
import 'package:mvvm/presentation/resources/values_manager.dart';

class StateRenderer extends StatelessWidget {
  StateRendererType stateRendererType;
  String message;
  String title;
  Function? retryAction;

  StateRenderer({
    Key? key,
    Failure? failure,
    String? message,
    String? title,
    required this.stateRendererType,
    required this.retryAction,
  })  : message = message ?? AppStrings.loading,
        title = title ?? EMPTY,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return _getStateWidget(context);
  }

  _getAnimatedWidget(String animation) {
    return SizedBox(
      height: AppSize.s100,
      width: AppSize.s100,
      child: Lottie.asset(animation),
    );
  }

  _getDialogContent(BuildContext context, List<Widget> children) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: children,
    );
  }

  _getItemsColumn(List<Widget> children) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: children,
    );
  }

  _getMessageWidget(String message) {
    return Text(
      message,
      style: getMediumStyle(color: ColorManager.black),
    );
  }

  _getPopUpDialog(BuildContext context, List<Widget> children) {
    return Dialog(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppSize.s14)),
      backgroundColor: Colors.transparent,
      child: Container(
        child: _getDialogContent(context, children),
        decoration: BoxDecoration(
            color: ColorManager.white,
            borderRadius: BorderRadius.circular(AppSize.s14),
            boxShadow: [
              BoxShadow(
                  color: Colors.black38,
                  blurRadius: AppSize.s12,
                  offset: Offset(0, AppSize.s12))
            ]),
      ),
    );
  }

  _getRetryWidget(String title, BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(AppPadding.p8),
        child: SizedBox(
          width: AppSize.s100,
          child: ElevatedButton(
              onPressed: () {
                if (stateRendererType ==
                    StateRendererType.FULLSCREEN_ERROR_STATE) {
                  retryAction!.call();
                } else {
                  Navigator.of(context).pop();
                }
              },
              child: Text(title)),
        ),
      ),
    );
  }

  Widget _getStateWidget(BuildContext context) {
    switch (stateRendererType) {
      case StateRendererType.POPUP_LOADING_STATE:
        return _getPopUpDialog(
            context, [_getAnimatedWidget(JsonAssets.loading)]);
      case StateRendererType.POPUP_ERROR_STATE:
        return _getPopUpDialog(context, [
          _getAnimatedWidget(JsonAssets.error),
          _getMessageWidget(message),
          _getRetryWidget(AppStrings.ok, context)
        ]);
      case StateRendererType.FULLSCREEN_LOADING_STATE:
        return _getItemsColumn([
          _getAnimatedWidget(JsonAssets.loading),
          _getMessageWidget(message)
        ]);
      case StateRendererType.FULLSCREEN_ERROR_STATE:
        return _getItemsColumn([
          _getAnimatedWidget(JsonAssets.error),
          _getMessageWidget(message),
          _getRetryWidget(AppStrings.retry, context)
        ]);
      case StateRendererType.CONTENT_SCREEN_STATE:
        return Container();
      case StateRendererType.EMPTY_SCREEN_STATE:
        return _getItemsColumn(
            [_getAnimatedWidget(JsonAssets.empty), _getMessageWidget(message)]);
      default:
        return Container();
    }
  }
}

enum StateRendererType {
  //POPUP
  POPUP_LOADING_STATE,
  POPUP_ERROR_STATE,
  // FULL SCREEN
  FULLSCREEN_LOADING_STATE,
  FULLSCREEN_ERROR_STATE,
  CONTENT_SCREEN_STATE,
  EMPTY_SCREEN_STATE,
}
