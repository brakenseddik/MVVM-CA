import 'package:dio/dio.dart';
import 'package:mvvm/app/contants.dart';
import 'package:mvvm/data/responses/forgot_response.dart';
import 'package:mvvm/data/responses/responses.dart';
import 'package:retrofit/http.dart';

part 'app_api.g.dart';

@RestApi(baseUrl: Constants.baseUrl)
abstract class AppServiceClient {
  factory AppServiceClient(Dio dio, {String baseUrl}) = _AppServiceClient;

  @POST("/customers/login")
  Future<AuthenticationResponse> login(
    @Field("email") String email,
    @Field("password") String password,
  );
  @POST("/customers/forgot")
  Future<ForgotResponse> forgot(
    @Field("email") String email,
  );
}
