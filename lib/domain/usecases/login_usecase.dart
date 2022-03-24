import 'package:dartz/dartz.dart';
import 'package:mvvm/app/functions.dart';
import 'package:mvvm/data/network/failure.dart';
import 'package:mvvm/data/requests/login_request.dart';
import 'package:mvvm/domain/models/model.dart';
import 'package:mvvm/domain/repositories/repository.dart';
import 'package:mvvm/domain/usecases/base_usecase.dart';

class LoginUseCase implements BaseUseCase<LoginUseCaseInput, Authentication> {
  Repository _repository;
  LoginUseCase(
    this._repository,
  );

  @override
  Future<Either<Failure, Authentication>> execute(
      LoginUseCaseInput input) async {
    DeviceInfo deviceInfo = await getDeviceDetails();
    return await _repository
        .login(LoginRequest(input.email, input.password));
  }
}

class LoginUseCaseInput {
  String email;
  String password;

  LoginUseCaseInput(this.email, this.password);
}
