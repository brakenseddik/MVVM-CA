import 'package:freezed_annotation/freezed_annotation.dart';

part 'freezed_dataclasses.freezed.dart';

@freezed
abstract class LoginObject with _$LoginObject {
  const factory LoginObject(String userName, String password) = _LoginObject;
}

@freezed
abstract class RegisterObject with _$RegisterObject {
  const factory RegisterObject(String email, String password, String name,
      String code, String mobile, String picture) = _RegisterObject;
}
