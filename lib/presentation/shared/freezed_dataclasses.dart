import 'package:freezed_annotation/freezed_annotation.dart';
part 'freezed_dataclasses.freezed.dart';

@freezed
abstract class LoginObject with _$LoginObject {
  const factory LoginObject(String userName, String password) = _LoginObject;
}
