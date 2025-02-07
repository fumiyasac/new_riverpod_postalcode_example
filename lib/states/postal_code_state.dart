import 'package:freezed_annotation/freezed_annotation.dart';
import '../models/address.dart';

part 'postal_code_state.freezed.dart';

@freezed
class PostalCodeState with _$PostalCodeState {
  const factory PostalCodeState({
    @Default(false) bool isLoading,
    String? errorMessage,
    Address? address,
    @Default('') String postalCode,
  }) = _PostalCodeState;
}