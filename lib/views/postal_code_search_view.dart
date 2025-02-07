import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../providers/postal_code_provider.dart';
import '../models/address.dart';

class PostalCodeSearchView extends HookConsumerWidget {
  const PostalCodeSearchView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(postalCodeProvider);
    final notifier = ref.read(postalCodeProvider.notifier);

    return Scaffold(
      appBar: AppBar(
        title: const Text('郵便番号検索'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              decoration: InputDecoration(
                labelText: '郵便番号',
                hintText: '例: 100-0001',
                border: const OutlineInputBorder(),
                suffixIcon: IconButton(
                  icon: const Icon(Icons.search),
                  onPressed: () => notifier.searchAddress(),
                ),
              ),
              onChanged: (value) => notifier.updatePostalCode(value),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 20),
            if (state.isLoading)
              const CircularProgressIndicator()
            else if (state.errorMessage != null)
              Text(
                state.errorMessage!,
                style: const TextStyle(color: Colors.red),
              )
            else if (state.address != null)
                AddressDisplay(address: state.address!)
          ],
        ),
      ),
    );
  }
}

class AddressDisplay extends StatelessWidget {
  final Address address;

  const AddressDisplay({super.key, required this.address});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '都道府県: (${address.prefcode})${address.prefecture}',
          style: const TextStyle(fontSize: 18),
        ),
        const SizedBox(height: 8),
        Text(
          '市区町村: ${address.address1}${address.address2}',
          style: const TextStyle(fontSize: 18),
        ),
      ],
    );
  }
}