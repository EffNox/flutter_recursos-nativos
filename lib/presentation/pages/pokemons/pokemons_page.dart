import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:miscelaneos/presentation/providers/providers.dart';

class PokemonsPage extends StatelessWidget {
  const PokemonsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: Center(child: PokemonsViewWidget()));
  }
}

class PokemonsViewWidget extends ConsumerStatefulWidget {
  const PokemonsViewWidget({super.key});

  @override
  PokemonsViewWidgetState createState() => PokemonsViewWidgetState();
}

class PokemonsViewWidgetState extends ConsumerState<PokemonsViewWidget> {
  final scrollController = ScrollController();

  void infinitScroll() {
    final currentPokemons = ref.read(pokemonIdsProvider);
    if (currentPokemons.length > 400) {
      scrollController.removeListener(infinitScroll);
      return;
    }
    if ((scrollController.position.pixels + 200) > scrollController.position.maxScrollExtent) {
      ref.read(pokemonIdsProvider.notifier).update((state) => [...state, ...List.generate(30, (i) => state.length + i + 1)]);
    }
  }

  @override
  void initState() {
    super.initState();
    scrollController.addListener(infinitScroll);
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      controller: scrollController,
      slivers: [
        SliverAppBar(
          title: const Text('Pokemons'),
          floating: true,
          backgroundColor: Colors.white.withOpacity(0.8),
        ),
        const _PokemonGridWidget()
      ],
    );
  }
}

class _PokemonGridWidget extends ConsumerWidget {
  const _PokemonGridWidget();
  @override
  Widget build(BuildContext context, ref) {
    final pokemonIds = ref.watch(pokemonIdsProvider);
    return SliverGrid.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: 2,
        mainAxisSpacing: 2,
      ),
      itemCount: pokemonIds.length,
      itemBuilder: (ctx, i) => GestureDetector(
        onTap: () => ctx.push('/pokemons/${i + 1}'),
        child: Image.network(
          'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/${i + 1}.png',
          fit: BoxFit.contain,
        ),
      ),
    );
  }
}
