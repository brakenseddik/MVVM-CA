import 'package:json_annotation/json_annotation.dart';
import 'package:mvvm/data/responses/banner_response.dart';
import 'package:mvvm/data/responses/responses.dart';
import 'package:mvvm/data/responses/service_response.dart';
import 'package:mvvm/data/responses/store_response.dart';
part 'home_response.g.dart';
@JsonSerializable()
class HomeDataResponse {
  @JsonKey(name: 'services')
  List<ServiceResponse>? services;
  @JsonKey(name: 'stores')
  List<StoreResponse>? stores;
  @JsonKey(name: 'banners')
  List<BannerResponse>? banners;

  HomeDataResponse(this.services, this.stores, this.banners);

// toJson
  Map<String, dynamic> toJson() => _$HomeDataResponseToJson(this);

//fromJson
  factory HomeDataResponse.fromJson(Map<String, dynamic> json) =>
      _$HomeDataResponseFromJson(json);
}

@JsonSerializable()
class HomeResponse extends BaseResponse {
  @JsonKey(name: 'data')
  HomeDataResponse? data;

  HomeResponse(this.data);

// toJson
  Map<String, dynamic> toJson() => _$HomeResponseToJson(this);

//fromJson
  factory HomeResponse.fromJson(Map<String, dynamic> json) =>
      _$HomeResponseFromJson(json);
}
