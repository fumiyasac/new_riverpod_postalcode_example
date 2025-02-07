import 'package:freezed_annotation/freezed_annotation.dart';

part 'address.freezed.dart';
part 'address.g.dart';

@freezed
class Address with _$Address {

  const factory Address({
    required String prefcode,
    required String prefecture,
    required String address1,
    required String address2,
  }) = _Address;

  factory Address.fromJson(Map<String, dynamic> json) =>
    _$AddressFromJson({
      'prefcode': json['data'][0]['prefcode'] ?? '',
      'prefecture': json['data'][0]['ja']['prefecture'] ?? '',
      'address1': json['data'][0]['ja']['address1'] ?? '',
      'address2': json['data'][0]['ja']['address2'] ?? '',
    });
}
