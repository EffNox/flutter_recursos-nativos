import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:miscelaneos/presentation/providers/sensors/magnetometer_provider.dart';

class MagnetometerPage extends ConsumerWidget {
  const MagnetometerPage({super.key});

  @override
  Widget build(BuildContext context, ref) {
    final magnetometer$ = ref.watch(magnetometerProvider);
    return Scaffold(
      appBar: AppBar(title: const Text('MagnetometerPage')),
      body: Center(
        child: magnetometer$.when(
          data: (data) => Text('$data', style: const TextStyle(fontSize: 40)),
          error: (error, stackTrace) => Text('$error'),
          loading: () => const CircularProgressIndicator(),
        ),
      ),
    );
  }
}
