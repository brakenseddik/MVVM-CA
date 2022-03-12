import 'dart:developer';

import 'package:mvvm/data/network/app_api.dart';
import 'package:mvvm/data/requests/login_request.dart';
import 'package:mvvm/data/responses/responses.dart';

abstract class RemoteDataSource {
  Future<AuthenticationResponse> login(LoginRequest loginRequest);
}

class RemoteDataSourceImplementor implements RemoteDataSource {
  final AppServicesClient _appServicesClient;

  RemoteDataSourceImplementor(
    this._appServicesClient,
  );

  @override
  Future<AuthenticationResponse> login(LoginRequest loginRequest) async {
    final res = await _appServicesClient.login(loginRequest.email,
        loginRequest.password, loginRequest.imei, loginRequest.deviceType);
    log(res.message!);
    return res;
  }
}
