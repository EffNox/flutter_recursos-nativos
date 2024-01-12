import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:miscelaneos/presentation/providers/providers.dart';

class GyroscopePage extends ConsumerWidget {
  const GyroscopePage({super.key});

  @override
  Widget build(BuildContext context, ref) {
    final gyroscope$ = ref.watch(gyroscopeProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('GyroscopePage')),
      body: Center(
        child: gyroscope$.when(
          data: (data) => Text(data.toString(), style: const TextStyle(fontSize: 30)),
          error: (error, trace) => Text('$error'),
          loading: () => const CircularProgressIndicator(),
        ),
      ),
    );
  }
}
