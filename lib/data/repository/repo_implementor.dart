import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:mvvm/data/data_source/remote_datasource.dart';
import 'package:mvvm/data/mappers/mapper.dart';
import 'package:mvvm/data/network/error_hundler.dart';
import 'package:mvvm/data/network/failure.dart';
import 'package:mvvm/data/network/network_info.dart';
import 'package:mvvm/data/requests/forget_request.dart';
import 'package:mvvm/data/requests/login_request.dart';
import 'package:mvvm/data/requests/register_request.dart';
import 'package:mvvm/domain/models/forgot_model.dart';
import 'package:mvvm/domain/models/home_model.dart';
import 'package:mvvm/domain/models/model.dart';
import 'package:mvvm/domain/repositories/repository.dart';

class RepositoryImplementor implements Repository {
  final RemoteDataSource _remoteDataSource;
  final NetworkInfo _networkInfo;
  RepositoryImplementor(
    this._remoteDataSource,
    this._networkInfo,
  );
  @override
  Future<Either<Failure, Forgot>> forgot(ForgotRequest forgotRequest) async {
    if (await _networkInfo.isConnected) {
      try {
        // its safe to call the API
        final response = await _remoteDataSource.forgot(forgotRequest);

        if (response.status == ApiInternalStatus.SUCCESS) // success
        {
          return Right(response.toDomain());
        } else {
          return Left(Failure(response.status ?? ApiInternalStatus.FAILURE,
              response.message ?? ResponseMessage.DEFAULT));
        }
      } catch (error) {
        return (Left(ErrorHandler.handle(error).failure));
      }
    } else {
      return Left(DataSource.NO_INTERNET_CONNECTION.getFailure());
    }
  }

  @override
  Future<Either<Failure, HomeObject>> getHome() async {
    if (await _networkInfo.isConnected) {
      try {
        final response = await _remoteDataSource.getHome();

        if (response.status == ApiInternalStatus.SUCCESS) // success
        {
          return Right(response.toDomain());
        } else {
          return Left(Failure(response.status ?? ApiInternalStatus.FAILURE,
              response.message ?? ResponseMessage.DEFAULT));
        }
      } catch (error) {
        log(error.toString());
        return (Left(ErrorHandler.handle(error).failure));
      }
    } else {
      return Left(DataSource.NO_INTERNET_CONNECTION.getFailure());
    }
  }

  @override
  Future<Either<Failure, Authentication>> login(
      LoginRequest loginRequest) async {
    if (await _networkInfo.isConnected) {
      try {
        // its safe to call the API
        final response = await _remoteDataSource.login(loginRequest);

        if (response.status == ApiInternalStatus.SUCCESS) // success
        {
          // return data (success)
          // return right
          return Right(response.toDomain());
        } else {
          // return biz logic error
          // return left
          return Left(Failure(response.status ?? ApiInternalStatus.FAILURE,
              response.message ?? ResponseMessage.DEFAULT));
        }
      } catch (error) {
        return (Left(ErrorHandler.handle(error).failure));
      }
    } else {
      // return connection error
      return Left(DataSource.NO_INTERNET_CONNECTION.getFailure());
    }
  }

  @override
  Future<Either<Failure, Authentication>> register(
      RegisterRequest registerRequest) async {
    if (await _networkInfo.isConnected) {
      try {
        final response = await _remoteDataSource.register(registerRequest);

        if (response.status == ApiInternalStatus.SUCCESS) // success
        {
          return Right(response.toDomain());
        } else {
          return Left(Failure(response.status ?? ApiInternalStatus.FAILURE,
              response.message ?? ResponseMessage.DEFAULT));
        }
      } catch (error) {
        return (Left(ErrorHandler.handle(error).failure));
      }
    } else {
      return Left(DataSource.NO_INTERNET_CONNECTION.getFailure());
    }
  }
}
