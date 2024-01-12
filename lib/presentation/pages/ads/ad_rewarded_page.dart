import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:miscelaneos/presentation/providers/providers.dart';

class AdRewardedPage extends ConsumerWidget {
  const AdRewardedPage({super.key});

  @override
  Widget build(BuildContext context, ref) {
    final adRewardedAsync = ref.watch(adRewardedProvider);
    final adPoints = ref.watch(adPointsProvider);

    ref.listen(adRewardedProvider, (previous, next) {
      if (!next.hasValue || next.value == null) return;
      next.value!.show(
        onUserEarnedReward: (ad, reward) {
          ref.read(adPointsProvider.notifier).update((state) => state + 10);
        },
      );
    });

    if (adRewardedAsync.isLoading) const Scaffold(body: Center(child: CircularProgressIndicator()));

    return Scaffold(
      appBar: AppBar(title: const Text('App AdRewardedPage')),
      body: Center(
        child: Text('Puntos actuales: $adPoints'),
      ),
    );
  }
}
