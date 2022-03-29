import 'package:dartz/dartz.dart';
import 'package:mvvm/data/network/failure.dart';
import 'package:mvvm/data/requests/forget_request.dart';
import 'package:mvvm/data/requests/login_request.dart';
import 'package:mvvm/domain/models/forgot_model.dart';
import 'package:mvvm/domain/models/model.dart';

abstract class Repository {
  Future<Either <Failure,Authentication>> login(LoginRequest loginRequest);
  Future<Either <Failure,Forgot>> forgot(ForgotRequest forgotRequest);
}
