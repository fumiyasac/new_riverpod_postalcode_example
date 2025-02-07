// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'address.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$AddressImpl _$$AddressImplFromJson(Map<String, dynamic> json) =>
    _$AddressImpl(
      prefcode: json['prefcode'] as String,
      prefecture: json['prefecture'] as String,
      address1: json['address1'] as String,
      address2: json['address2'] as String,
    );

Map<String, dynamic> _$$AddressImplToJson(_$AddressImpl instance) =>
    <String, dynamic>{
      'prefcode': instance.prefcode,
      'prefecture': instance.prefecture,
      'address1': instance.address1,
      'address2': instance.address2,
    };
