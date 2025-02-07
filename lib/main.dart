import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import './views/postal_code_search_view.dart';

void main() {
  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '郵便番号検索',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const PostalCodeSearchView(),
    );
  }
}
