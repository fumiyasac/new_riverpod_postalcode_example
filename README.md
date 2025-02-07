# New Rivepod Postalcode Example

## 概要

郵便番号APIを利用して、検索した郵便番号`(例: 100-0001)`から下記の情報を取得して表示するサンプルになります。

- 都道府県コード番号
- 都道府県名
- 市区町村名

### 郵便番号API

- GitHub:
  - https://github.com/madefor/postal-code-api
- Demo:
  - https://madefor.github.io/postal-code-api/

## 新しいRiverpodを利用して構築する

Riverpod2.0からは`StateNotifier`が非推奨となり、`@riverpod`を利用した書き方へ変更する必要があります。

- Riverpod
  - https://pub.dev/packages/riverpod
  - https://riverpod.dev/ja/ 

### 想定アーキテクチャ概要

```mermaid
flowchart LR
    id1(View) --> id2
    id2(Provider) --> id3
    id3(Repository) --> id4
    id4(API Request)
```

### 新旧の書き方を比較する

#### ① Address.daft (Model)

__【Before】__

```dart:address.dart
class Address {
  final String prefcode;
  final String prefecture;
  final String address1;
  final String address2;

  Address({
    required this.prefcode,
    required this.prefecture,
    required this.address1,
    required this.address2,
  });

  factory Address.fromJson(Map<String, dynamic> json) {
    return Address(
      prefcode: json['data'][0]['prefcode'] ?? '',
      prefecture: json['data'][0]['ja']['prefecture'] ?? '',
      address1: json['data'][0]['ja']['address1'] ?? '',
      address2: json['data'][0]['ja']['address2'] ?? '',
    );
  }
}
```

__【After】__

```dart:address.dart
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
```

※ 追加後に`$ flutter pub run build_runner build`を実行する。

#### ② PostalCodeRepository.daft (Repository)

__【Before】__

```dart:postal_code_repository.dart
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../models/address.dart';

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
```

__【After】__

```dart:postal_code_repository.dart
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../models/address.dart';

part 'postal_code_repository.g.dart';

@riverpod
PostalCodeRepository postalCodeRepository(PostalCodeRepositoryRef ref) {
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
```

#### ③ postal_code_state.daft (State)

__【Before】__

```dart:postal_code_repository.dart
import '../models/address.dart';

class PostalCodeState {
  final bool isLoading;
  final String? errorMessage;
  final Address? address;
  final String postalCode;

  PostalCodeState({
    this.isLoading = false,
    this.errorMessage,
    this.address,
    this.postalCode = '',
  });

  PostalCodeState copyWith({
    bool? isLoading,
    String? errorMessage,
    Address? address,
    String? postalCode,
  }) {
    return PostalCodeState(
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage,
      address: address ?? this.address,
      postalCode: postalCode ?? this.postalCode,
    );
  }
}
```

__【After】__

```dart:postal_code_repository.dart
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
```

#### ④ postal_code_provider.daft (Provider)

__【Before】__

```dart:postal_code_repository.dart
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_example/view_models/postal_code_state.dart';
import '../repositories/postal_code_repository.dart';

final postalCodeRepositoryProvider = Provider((ref) => PostalCodeRepository());

final postalCodeViewModelProvider = StateNotifierProvider<PostalCodeViewModel, PostalCodeState>(
      (ref) => PostalCodeViewModel(ref.read(postalCodeRepositoryProvider)),
);

class PostalCodeViewModel extends StateNotifier<PostalCodeState> {
  final PostalCodeRepository _repository;

  PostalCodeViewModel(this._repository) : super(PostalCodeState());

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
      final address = await _repository.getAddress(state.postalCode);
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
```

__【After】__

```dart:postal_code_repository.dart
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
```

※ 追加後に`$ flutter pub run build_runner build`を実行する。

### 参考資料

- [YOUTRUSTアプリを支えるデータストアの技術 〜改良版〜](https://tech.youtrust.co.jp/entry/app-data-store/improved)
- [Riverpod GeneratorでのProvider自動生成をまとめてみた](https://dev.classmethod.jp/articles/riverpod-generator-provider/)
