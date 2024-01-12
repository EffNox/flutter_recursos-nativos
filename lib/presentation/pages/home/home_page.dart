import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:miscelaneos/presentation/providers/providers.dart';
import 'package:miscelaneos/presentation/widgets/shared/main_menu.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, ref) {
    final adBannerAsync = ref.watch(adBannerProvider);
    return Scaffold(
        body: Column(
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: CustomScrollView(
              slivers: [
                SliverAppBar(
                  title: const Text('Miscelaneos'),
                  actions: [
                    IconButton(icon: const Icon(Icons.settings), onPressed: () => context.push('/permissions')),
                  ],
                ),
                const MainMenuWidget(),
              ],
            ),
          ),
        ),
        adBannerAsync.when(
          data: (data) => SizedBox(
            width: data.size.width.toDouble(),
            height: data.size.height.toDouble(),
            child: AdWidget(ad: data),
          ),
          error: (error, _) => Text('$error'),
          loading: () => const CircularProgressIndicator(),
        ),
      ],
    ));
  }
}
