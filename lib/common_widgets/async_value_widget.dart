import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

class AsyncValueWidget<T> extends StatelessWidget {
  const AsyncValueWidget({super.key, required this.value, required this.data});

  final AsyncValue<T> value;
  final Widget Function(T) data;
  @override
  Widget build(BuildContext context) {
    return value.when(
        data: data,
        error: (error, stackTrace) => Center(
                child: Text(
              'Error: $error',
              style: const TextStyle(color: Colors.red),
            )),
        loading: () => const Center(child: CircularProgressIndicator()));
  }
}
