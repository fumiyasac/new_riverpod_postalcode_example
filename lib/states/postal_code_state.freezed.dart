// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'postal_code_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$PostalCodeState {
  bool get isLoading => throw _privateConstructorUsedError;
  String? get errorMessage => throw _privateConstructorUsedError;
  Address? get address => throw _privateConstructorUsedError;
  String get postalCode => throw _privateConstructorUsedError;

  /// Create a copy of PostalCodeState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $PostalCodeStateCopyWith<PostalCodeState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PostalCodeStateCopyWith<$Res> {
  factory $PostalCodeStateCopyWith(
          PostalCodeState value, $Res Function(PostalCodeState) then) =
      _$PostalCodeStateCopyWithImpl<$Res, PostalCodeState>;
  @useResult
  $Res call(
      {bool isLoading,
      String? errorMessage,
      Address? address,
      String postalCode});

  $AddressCopyWith<$Res>? get address;
}

/// @nodoc
class _$PostalCodeStateCopyWithImpl<$Res, $Val extends PostalCodeState>
    implements $PostalCodeStateCopyWith<$Res> {
  _$PostalCodeStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of PostalCodeState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isLoading = null,
    Object? errorMessage = freezed,
    Object? address = freezed,
    Object? postalCode = null,
  }) {
    return _then(_value.copyWith(
      isLoading: null == isLoading
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      errorMessage: freezed == errorMessage
          ? _value.errorMessage
          : errorMessage // ignore: cast_nullable_to_non_nullable
              as String?,
      address: freezed == address
          ? _value.address
          : address // ignore: cast_nullable_to_non_nullable
              as Address?,
      postalCode: null == postalCode
          ? _value.postalCode
          : postalCode // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }

  /// Create a copy of PostalCodeState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $AddressCopyWith<$Res>? get address {
    if (_value.address == null) {
      return null;
    }

    return $AddressCopyWith<$Res>(_value.address!, (value) {
      return _then(_value.copyWith(address: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$PostalCodeStateImplCopyWith<$Res>
    implements $PostalCodeStateCopyWith<$Res> {
  factory _$$PostalCodeStateImplCopyWith(_$PostalCodeStateImpl value,
          $Res Function(_$PostalCodeStateImpl) then) =
      __$$PostalCodeStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {bool isLoading,
      String? errorMessage,
      Address? address,
      String postalCode});

  @override
  $AddressCopyWith<$Res>? get address;
}

/// @nodoc
class __$$PostalCodeStateImplCopyWithImpl<$Res>
    extends _$PostalCodeStateCopyWithImpl<$Res, _$PostalCodeStateImpl>
    implements _$$PostalCodeStateImplCopyWith<$Res> {
  __$$PostalCodeStateImplCopyWithImpl(
      _$PostalCodeStateImpl _value, $Res Function(_$PostalCodeStateImpl) _then)
      : super(_value, _then);

  /// Create a copy of PostalCodeState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isLoading = null,
    Object? errorMessage = freezed,
    Object? address = freezed,
    Object? postalCode = null,
  }) {
    return _then(_$PostalCodeStateImpl(
      isLoading: null == isLoading
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      errorMessage: freezed == errorMessage
          ? _value.errorMessage
          : errorMessage // ignore: cast_nullable_to_non_nullable
              as String?,
      address: freezed == address
          ? _value.address
          : address // ignore: cast_nullable_to_non_nullable
              as Address?,
      postalCode: null == postalCode
          ? _value.postalCode
          : postalCode // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$PostalCodeStateImpl implements _PostalCodeState {
  const _$PostalCodeStateImpl(
      {this.isLoading = false,
      this.errorMessage,
      this.address,
      this.postalCode = ''});

  @override
  @JsonKey()
  final bool isLoading;
  @override
  final String? errorMessage;
  @override
  final Address? address;
  @override
  @JsonKey()
  final String postalCode;

  @override
  String toString() {
    return 'PostalCodeState(isLoading: $isLoading, errorMessage: $errorMessage, address: $address, postalCode: $postalCode)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PostalCodeStateImpl &&
            (identical(other.isLoading, isLoading) ||
                other.isLoading == isLoading) &&
            (identical(other.errorMessage, errorMessage) ||
                other.errorMessage == errorMessage) &&
            (identical(other.address, address) || other.address == address) &&
            (identical(other.postalCode, postalCode) ||
                other.postalCode == postalCode));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, isLoading, errorMessage, address, postalCode);

  /// Create a copy of PostalCodeState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PostalCodeStateImplCopyWith<_$PostalCodeStateImpl> get copyWith =>
      __$$PostalCodeStateImplCopyWithImpl<_$PostalCodeStateImpl>(
          this, _$identity);
}

abstract class _PostalCodeState implements PostalCodeState {
  const factory _PostalCodeState(
      {final bool isLoading,
      final String? errorMessage,
      final Address? address,
      final String postalCode}) = _$PostalCodeStateImpl;

  @override
  bool get isLoading;
  @override
  String? get errorMessage;
  @override
  Address? get address;
  @override
  String get postalCode;

  /// Create a copy of PostalCodeState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PostalCodeStateImplCopyWith<_$PostalCodeStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
