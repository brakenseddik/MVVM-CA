import 'package:mvvm/data/network/app_api.dart';
import 'package:mvvm/data/requests/forget_request.dart';
import 'package:mvvm/data/requests/login_request.dart';
import 'package:mvvm/data/responses/forgot_response.dart';
import 'package:mvvm/data/responses/responses.dart';

abstract class RemoteDataSource {
  Future<AuthenticationResponse> login(LoginRequest loginRequest);
  Future<ForgotResponse> forgot(ForgotRequest forgotRequest);
}

class RemoteDataSourceImplementor implements RemoteDataSource {
  final AppServiceClient _appServicesClient;

  RemoteDataSourceImplementor(
    this._appServicesClient,
  );

  @override
  Future<AuthenticationResponse> login(LoginRequest loginRequest) async {
    return await _appServicesClient.login(
      loginRequest.email,
      loginRequest.password,
    );
  }

  @override
  Future<ForgotResponse> forgot(ForgotRequest forgotRequest) async {
    return await _appServicesClient.forgot(forgotRequest.email);
  }
}
