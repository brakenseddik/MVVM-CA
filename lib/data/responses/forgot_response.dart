import 'package:json_annotation/json_annotation.dart';
import 'package:mvvm/data/responses/responses.dart';

part 'forgot_response.g.dart';

@JsonSerializable()
class ForgotResponse extends BaseResponse {
  @JsonKey(name: 'support')
  String? support;
  ForgotResponse(this.support);

  factory ForgotResponse.fromJson(Map<String, dynamic> json) =>
      _$ForgotResponseFromJson(json);
  Map<String, dynamic> toJson() => _$ForgotResponseToJson(this);
}
