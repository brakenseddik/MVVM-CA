import 'package:mvvm/data/network/app_api.dart';
import 'package:mvvm/data/requests/forget_request.dart';
import 'package:mvvm/data/requests/login_request.dart';
import 'package:mvvm/data/requests/register_request.dart';
import 'package:mvvm/data/responses/forgot_response.dart';
import 'package:mvvm/data/responses/home_response.dart';
import 'package:mvvm/data/responses/responses.dart';

abstract class RemoteDataSource {
  Future<ForgotResponse> forgot(ForgotRequest forgotRequest);
  Future<HomeResponse> getHome();
  Future<AuthenticationResponse> login(LoginRequest loginRequest);
  Future<AuthenticationResponse> register(RegisterRequest registerRequest);
}

class RemoteDataSourceImplementor implements RemoteDataSource {
  final AppServiceClient _appServicesClient;

  RemoteDataSourceImplementor(
    this._appServicesClient,
  );

  @override
  Future<ForgotResponse> forgot(ForgotRequest forgotRequest) async {
    return await _appServicesClient.forgot(forgotRequest.email);
  }

  @override
  Future<HomeResponse> getHome() async {
    return await _appServicesClient.getHome();
  }

  @override
  Future<AuthenticationResponse> login(LoginRequest loginRequest) async {
    return await _appServicesClient.login(
      loginRequest.email,
      loginRequest.password,
    );
  }

  @override
  Future<AuthenticationResponse> register(
      RegisterRequest registerRequest) async {
    return await _appServicesClient.register(
        registerRequest.email,
        registerRequest.password,
        registerRequest.name,
        registerRequest.code,
        registerRequest.mobile,
        "");
  }
}
