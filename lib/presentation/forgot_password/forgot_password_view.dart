import 'package:flutter/material.dart';
import 'package:mvvm/app/app_prefs.dart';
import 'package:mvvm/app/di.dart';
import 'package:mvvm/presentation/forgot_password/forgot_password_viemodel.dart';
import 'package:mvvm/presentation/resources/assets_manager.dart';
import 'package:mvvm/presentation/resources/strings_manager.dart';
import 'package:mvvm/presentation/resources/values_manager.dart';
import 'package:mvvm/presentation/shared/state_renderer/state_render_impl.dart';

class ForgotPasswordView extends StatefulWidget {
  const ForgotPasswordView({Key? key}) : super(key: key);

  @override
  _ForgotPasswordViewState createState() => _ForgotPasswordViewState();
}

class _ForgotPasswordViewState extends State<ForgotPasswordView> {
  TextEditingController _emailController = TextEditingController();
  ForgotPassViewModel _forgotPassViewModel = instance<ForgotPassViewModel>();
  AppPreferences _appPreferences = instance<AppPreferences>();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<FlowState>(
      stream: _forgotPassViewModel.outputState,
      builder: (_, snapshot) {
        return snapshot.data?.getScreenWidget(
                context,
                _getContent(
                  emailController: _emailController,
                  forgotPassViewModel: _forgotPassViewModel,
                  formKey: _formKey,
                ), () {
              _forgotPassViewModel.forgot();
            }) ??
            _getContent(
              emailController: _emailController,
              forgotPassViewModel: _forgotPassViewModel,
              formKey: _formKey,
            );
      },
    );
  }

  @override
  void dispose() {
    _forgotPassViewModel.dispose();
    super.dispose();
  }

  @override
  void initState() {
    _bind();

    super.initState();
  }

  _bind() {
    _forgotPassViewModel.start();
    _emailController.addListener(
        () => _forgotPassViewModel.setUserName(_emailController.text));
  }
}

class _getContent extends StatelessWidget {
  final GlobalKey<FormState> _formKey;

  final ForgotPassViewModel _forgotPassViewModel;
  final TextEditingController _emailController;
  const _getContent({
    Key? key,
    required GlobalKey<FormState> formKey,
    required ForgotPassViewModel forgotPassViewModel,
    required TextEditingController emailController,
  })  : _formKey = formKey,
        _forgotPassViewModel = forgotPassViewModel,
        _emailController = emailController,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: _formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(ImageAssets.splashLogo),
            SizedBox(
              height: AppSize.s40,
            ),
            StreamBuilder<bool>(
                stream: _forgotPassViewModel.isOutputIsUserNameValid,
                builder: (context, snapshot) {
                  return Padding(
                    padding: EdgeInsets.only(
                        left: AppPadding.p28, right: AppPadding.p28),
                    child: TextFormField(
                      keyboardType: TextInputType.emailAddress,
                      controller: _emailController,
                      decoration: InputDecoration(
                          hintText: AppStrings.username,
                          labelText: AppStrings.username,
                          errorText: (snapshot.data ?? true)
                              ? null
                              : AppStrings.usernameError),
                    ),
                  );
                }),
            SizedBox(height: AppSize.s28),
            StreamBuilder<bool>(
                stream: _forgotPassViewModel.isOutputIsUserNameValid,
                builder: (context, snapshot) {
                  return Padding(
                      padding: EdgeInsets.only(
                          left: AppPadding.p28, right: AppPadding.p28),
                      child: SizedBox(
                        width: double.infinity,
                        height: 50,
                        child: ElevatedButton(
                            onPressed: (snapshot.data ?? false)
                                ? () {
                                    _forgotPassViewModel.forgot();
                                  }
                                : null,
                            child: Text(AppStrings.send)),
                      ));
                }),
          ],
        ),
      ),
    );
  }
}
