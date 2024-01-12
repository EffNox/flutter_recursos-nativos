import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:miscelaneos/presentation/providers/providers.dart';

class LocationPage extends ConsumerWidget {
  const LocationPage({super.key});

  @override
  Widget build(BuildContext context, ref) {
    final userLocationAsync = ref.watch(userLocationProvider);
    final wathLocationAsync = ref.watch(watchLocationProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Ubicación')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Ubicación Actual'),
            userLocationAsync.when(
              data: (data) => Text('$data'),
              error: (error, _) => Text('$error'),
              loading: () => const CircularProgressIndicator(),
            ),
            const SizedBox(height: 30),
            const Text('Seguimiento de ubicación'),
            wathLocationAsync.when(
              data: (data) => Text('$data'),
              error: (error, _) => Text('$error'),
              loading: () => const CircularProgressIndicator(),
            ),
          ],
        ),
      ),
    );
  }
}
