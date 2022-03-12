import 'package:dartz/dartz.dart';
import 'package:mvvm/data/network/failure.dart';
import 'package:mvvm/data/requests/login_request.dart';
import 'package:mvvm/domain/models/model.dart';

abstract class Repository {
  Future<Either <Failure,Authentication>> login(LoginRequest loginRequest);
}
