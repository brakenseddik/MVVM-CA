import 'package:dartz/dartz.dart';
import 'package:mvvm/data/network/failure.dart';
import 'package:mvvm/data/requests/forget_request.dart';
import 'package:mvvm/domain/models/forgot_model.dart';
import 'package:mvvm/domain/repositories/repository.dart';
import 'package:mvvm/domain/usecases/base_usecase.dart';

class ForgotUseCase implements BaseUseCase<ForgotUseCaseInput, Forgot> {
  Repository _repository;
  ForgotUseCase(
    this._repository,
  );

  @override
  Future<Either<Failure, Forgot>> execute(
      ForgotUseCaseInput input) async {
    return await _repository
        .forgot(ForgotRequest(input.email));
  }
}

class ForgotUseCaseInput {
  String email;
 
  ForgotUseCaseInput(this.email,);
}
