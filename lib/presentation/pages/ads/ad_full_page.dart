import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:miscelaneos/presentation/providers/providers.dart';

class AdFullPage extends ConsumerWidget {
  const AdFullPage({super.key});

  @override
  Widget build(BuildContext context, ref) {
    final interstitialAdAsync = ref.watch(adInterstitialProvider);

    ref.listen(adInterstitialProvider, (previous, next) {
      if (!next.hasValue) return;
      if (next.value == null) return;
      next.value!.show();
    });

    if (interstitialAdAsync.isLoading) return const Scaffold(body: Center(child: CircularProgressIndicator()));

    return Scaffold(
      appBar: AppBar(title: const Text('App AdFull')),
      body: const Center(
        child: Placeholder(),
      ),
    );
  }
}
