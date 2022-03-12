import 'package:dio/dio.dart';
import 'package:mvvm/app/contants.dart';
import 'package:mvvm/data/responses/responses.dart';
import 'package:retrofit/http.dart';

part 'app_api.g.dart';

@RestApi(baseUrl: Constants.baseUrl)
abstract class AppServicesClient {
  factory AppServicesClient(Dio dio, {String baseUrl}) = _AppServicesClient;

  @POST("/customers/login")
  Future<AuthenticationResponse> login(
    @Field('email') String email,
    @Field('password') String password,
    @Field('imei') String imei,
    @Field('device_type') String deviceType,
  );
}
