import 'package:flutter_test/flutter_test.dart';
import 'package:new_riverpod_postalcode_example/models/address.dart';

void main() {
  group('Address Model Tests', () {
    test('should create Address from JSON', () {
      final json = {
        'data': [
          {
            "prefcode": "13",
            "ja": {
              "prefecture": "東京都",
              "address1": "豊島区",
              "address2": "南大塚",
              "address3": "",
              "address4": ""
            },
            "en": {
              "prefecture": "Tokyo",
              "address1": "Toshima-ku",
              "address2": "Minamiotsuka",
              "address3": "",
              "address4": ""
            }
          }
        ]
      };

      final address = Address.fromJson(json);

      expect(address.prefcode, "13");
      expect(address.prefecture, "東京都");
      expect(address.address1, "豊島区");
      expect(address.address2, "南大塚");
    });
  });
}