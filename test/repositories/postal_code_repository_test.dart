import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import 'package:http/http.dart' as http;
import 'package:new_riverpod_postalcode_example/repositories/postal_code_repository.dart';

@GenerateMocks([http.Client])
import 'postal_code_repository_test.mocks.dart';

void main() {
  group('PostalCodeRepository Tests', () {
    late MockClient mockClient;
    late PostalCodeRepository repository;

    setUp(() {
      mockClient = MockClient();
      repository = PostalCodeRepository();
    });

    test('should fetch address successfully', () async {
      const postalCode = '170-0005';
      final responseJson = '''
      {
        "code": "1700005",
        "data": [
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
      } 
      ''';

      when(mockClient.get(any)).thenAnswer(
            (_) async => http.Response(responseJson, 200),
      );

      final address = await repository.getAddress(postalCode);

      expect(address.prefecture, equals('東京都'));
      expect(address.address1, equals('豊島区'));
      expect(address.address2, equals('南大塚'));
    });

    test('should throw exception on API error', () {
      const postalCode = '999-9999';

      when(mockClient.get(any)).thenAnswer(
            (_) async => http.Response('Error', 404),
      );

      expect(
            () => repository.getAddress(postalCode),
        throwsException,
      );
    });
  });
}