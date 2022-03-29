// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'forgot_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ForgotResponse _$ForgotResponseFromJson(Map<String, dynamic> json) =>
    ForgotResponse(
      json['support'] as String?,
    )
      ..status = json['status'] as int?
      ..message = json['message'] as String?;

Map<String, dynamic> _$ForgotResponseToJson(ForgotResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'message': instance.message,
      'support': instance.support,
    };
