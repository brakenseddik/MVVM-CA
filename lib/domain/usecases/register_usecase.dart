import 'package:dartz/dartz.dart';
import 'package:mvvm/data/network/failure.dart';
import 'package:mvvm/data/requests/register_request.dart';
import 'package:mvvm/domain/models/model.dart';
import 'package:mvvm/domain/repositories/repository.dart';
import 'package:mvvm/domain/usecases/base_usecase.dart';

class RegisterUseCase
    implements BaseUseCase<RegisterUseCaseInput, Authentication> {
  Repository _repository;
  RegisterUseCase(
    this._repository,
  );

  @override
  Future<Either<Failure, Authentication>> execute(
      RegisterUseCaseInput input) async {
    return await _repository.register(RegisterRequest(input.email,
        input.password, input.name, input.code, input.mobile, input.picture));
  }
}

class RegisterUseCaseInput {
  String email;
  String password;
  String name;
  String code;
  String mobile;
  String picture;

  RegisterUseCaseInput(
    this.email,
    this.password,
    this.name,
    this.code,
    this.mobile,
    this.picture,
  );
}
