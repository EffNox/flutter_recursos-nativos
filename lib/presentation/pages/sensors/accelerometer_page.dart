import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:miscelaneos/presentation/providers/providers.dart';

class AccelerometerPage extends ConsumerWidget {
  const AccelerometerPage({super.key});

  @override
  Widget build(BuildContext context, ref) {
    final accelerometer$ = ref.watch(accelerometerUserProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Acelerómetro')),
      body: Center(
        child: accelerometer$.when(
          data: (data) => Text(data.toString(), style: const TextStyle(fontSize: 35)),
          error: (error, stackTrace) => Text('$error'),
          loading: () => const CircularProgressIndicator(),
        ),
      ),
    );
  }
}
