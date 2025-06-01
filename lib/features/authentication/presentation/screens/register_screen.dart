import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';

class RegisterScreen extends ConsumerStatefulWidget {
  const RegisterScreen({super.key});

  @override
  ConsumerState<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends ConsumerState<RegisterScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Register'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            // Handle registration logic here
          },
          child: const Text('Register'),
        ),
      ),
    );
  }
}
