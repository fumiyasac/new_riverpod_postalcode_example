import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import 'package:new_riverpod_postalcode_example/models/address.dart';
import 'package:new_riverpod_postalcode_example/views/postal_code_search_view.dart';
import 'package:new_riverpod_postalcode_example/repositories/postal_code_repository.dart';

@GenerateNiceMocks([MockSpec<PostalCodeRepository>()])
import 'postal_code_search_view_test.mocks.dart';

void main() {
  group('PostalCodeSearchView Widget Tests', () {
    late MockPostalCodeRepository mockRepository;

    setUp(() {
      mockRepository = MockPostalCodeRepository();
    });

    testWidgets('should render initial state correctly', (tester) async {
      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            postalCodeRepositoryProvider.overrideWithValue(mockRepository),
          ],
          child: const MaterialApp(
            home: PostalCodeSearchView(),
          ),
        ),
      );

      expect(find.text('郵便番号検索(New)'), findsOneWidget);
      expect(find.byType(TextField), findsOneWidget);
      expect(find.byIcon(Icons.search), findsOneWidget);
    });

    testWidgets('should show loading indicator during search', (tester) async {
      final mockAddress = Address(prefcode: '13', prefecture: '東京都', address1: '豊島区', address2: '南大塚');
      when(mockRepository.getAddress(any)).thenAnswer(
            (_) => Future.delayed(
          const Duration(milliseconds: 100),
              () => mockAddress,
        ),
      );

      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            postalCodeRepositoryProvider.overrideWithValue(mockRepository),
          ],
          child: const MaterialApp(
            home: PostalCodeSearchView(),
          ),
        ),
      );

      await tester.enterText(find.byType(TextField), '170-0005');
      await tester.tap(find.byIcon(Icons.search));
      await tester.pump();

      expect(find.byType(CircularProgressIndicator), findsOneWidget);

      await tester.pumpAndSettle();

      expect(find.text('都道府県: (13)東京都'), findsOneWidget);
      expect(find.text('市区町村: 豊島区南大塚'), findsOneWidget);

      verify(mockRepository.getAddress('170-0005')).called(1);
    });

    testWidgets('should show error message on failure', (tester) async {
      when(mockRepository.getAddress(any)).thenThrow(
        Exception('住所の取得に失敗しました'),
      );

      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            postalCodeRepositoryProvider.overrideWithValue(mockRepository),
          ],
          child: const MaterialApp(
            home: PostalCodeSearchView(),
          ),
        ),
      );

      await tester.enterText(find.byType(TextField), '999-9999');
      await tester.tap(find.byIcon(Icons.search));
      await tester.pumpAndSettle();

      expect(find.text('Exception: 住所の取得に失敗しました'), findsOneWidget);
      verify(mockRepository.getAddress('999-9999')).called(1);
    });
  });
}