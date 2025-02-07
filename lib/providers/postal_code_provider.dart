import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../states/postal_code_state.dart';
import '../repositories/postal_code_repository.dart';

part 'postal_code_provider.g.dart';

@riverpod
class PostalCode extends _$PostalCode {
  @override
  PostalCodeState build() => const PostalCodeState();

  void updatePostalCode(String postalCode) {
    state = state.copyWith(postalCode: postalCode);
  }

  Future<void> searchAddress() async {
    if (state.postalCode.isEmpty) {
      state = state.copyWith(errorMessage: '郵便番号を入力してください');
      return;
    }

    try {
      state = state.copyWith(isLoading: true, errorMessage: null);
      final repository = ref.read(postalCodeRepositoryProvider);
      final address = await repository.getAddress(state.postalCode);
      state = state.copyWith(
        isLoading: false,
        address: address,
        errorMessage: null,
      );
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        errorMessage: e.toString(),
      );
    }
  }
}