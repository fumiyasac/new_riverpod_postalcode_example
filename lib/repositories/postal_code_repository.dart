import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../models/address.dart';

part 'postal_code_repository.g.dart';

@riverpod
PostalCodeRepository postalCodeRepository(Ref ref) {
  return PostalCodeRepository();
}

class PostalCodeRepository {
  Future<Address> getAddress(String postalCode) async {
    final cleanPostalCode = postalCode.replaceAll('-', '/');
    final response = await http.get(
      Uri.parse('https://madefor.github.io/postal-code-api/api/v1/$cleanPostalCode.json'),
    );

    if (response.statusCode == 200) {
      return Address.fromJson(json.decode(response.body));
    } else {
      throw Exception('住所の取得に失敗しました');
    }
  }
}