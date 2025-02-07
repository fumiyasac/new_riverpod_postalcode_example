import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:new_riverpod_postalcode_example/models/address.dart';
import 'package:new_riverpod_postalcode_example/providers/postal_code_provider.dart';
import 'package:new_riverpod_postalcode_example/repositories/postal_code_repository.dart';

@GenerateNiceMocks([MockSpec<PostalCodeRepository>()])
import 'postal_code_provider_test.mocks.dart';

void main() {
  group('PostalCodeProvider Tests', () {
    late ProviderContainer container;
    late MockPostalCodeRepository mockRepository;

    setUp(() {
      mockRepository = MockPostalCodeRepository();
      container = ProviderContainer(
        overrides: [
          postalCodeRepositoryProvider.overrideWithValue(mockRepository),
        ],
      );
      addTearDown(container.dispose);
    });

    test('initial state should be empty', () {
      final state = container.read(postalCodeProvider);
      expect(state.isLoading, isFalse);
      expect(state.errorMessage, isNull);
      expect(state.address, isNull);
      expect(state.postalCode, isEmpty);
    });

    test('should update postal code', () {
      container.read(postalCodeProvider.notifier).updatePostalCode('170-0005');
      final state = container.read(postalCodeProvider);
      expect(state.postalCode, equals('170-0005'));
    });

    test('should show error for empty postal code', () async {
      await container.read(postalCodeProvider.notifier).searchAddress();
      final state = container.read(postalCodeProvider);
      expect(state.errorMessage, equals('郵便番号を入力してください'));
    });

    test('should fetch address successfully', () async {
      const postalCode = '170-0005';
      final mockAddress = Address(prefcode: '13', prefecture: '東京都', address1: '豊島区', address2: '南大塚');

      when(mockRepository.getAddress(any)).thenAnswer(
            (_) async => mockAddress,
      );

      final notifier = container.read(postalCodeProvider.notifier);
      notifier.updatePostalCode(postalCode);
      await notifier.searchAddress();

      final state = container.read(postalCodeProvider);
      expect(state.isLoading, isFalse);
      expect(state.errorMessage, isNull);
      expect(state.address?.prefcode, equals('13'));
      expect(state.address?.prefecture, equals('東京都'));
      expect(state.address?.address1, equals('豊島区'));
      expect(state.address?.address2, equals('南大塚'));

      verify(mockRepository.getAddress(postalCode)).called(1);
    });

    test('should handle error during address fetch', () async {
      const postalCode = '999-9999';
      const errorMessage = '住所の取得に失敗しました';

      when(mockRepository.getAddress(any)).thenThrow(
        Exception(errorMessage),
      );

      final notifier = container.read(postalCodeProvider.notifier);
      notifier.updatePostalCode(postalCode);
      await notifier.searchAddress();

      final state = container.read(postalCodeProvider);
      expect(state.isLoading, isFalse);
      expect(state.errorMessage, contains(errorMessage));
      expect(state.address, isNull);

      verify(mockRepository.getAddress(postalCode)).called(1);
    });
  });
}