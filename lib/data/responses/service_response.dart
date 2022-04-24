import 'package:json_annotation/json_annotation.dart';

part 'service_response.g.dart';

@JsonSerializable()
class ServiceResponse {
  @JsonKey(name: 'id')
  int? id;
  @JsonKey(name: 'title')
  String? title;
  @JsonKey(name: 'image')
  String? image;

  ServiceResponse(this.id, this.title, this.image);

// toJson
  factory ServiceResponse.fromJson(Map<String, dynamic> json) =>
      _$ServiceResponseFromJson(json);

//fromJson
  Map<String, dynamic> toJson() => _$ServiceResponseToJson(this);
}
