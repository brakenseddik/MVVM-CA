import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:mvvm/data/data_source/remote_datasource.dart';
import 'package:mvvm/data/mappers/mapper.dart';
import 'package:mvvm/data/network/error_hundler.dart';
import 'package:mvvm/data/network/failure.dart';
import 'package:mvvm/data/network/network_info.dart';
import 'package:mvvm/data/requests/login_request.dart';
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
}
