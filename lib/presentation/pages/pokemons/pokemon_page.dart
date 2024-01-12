import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:miscelaneos/config/config.dart';
import 'package:miscelaneos/dom/dom.dart';
import 'package:miscelaneos/presentation/providers/providers.dart';

class PokemonPage extends ConsumerWidget {
  final String pokemonId;
  const PokemonPage({super.key, required this.pokemonId});

  @override
  Widget build(BuildContext context, ref) {
    final pokemonAsync = ref.watch(pokemonProvider(pokemonId));

    return pokemonAsync.when(
      data: (v) => _PokemonWidget(pokemon: v),
      error: (error, stackTrace) => _ErrorWidget(message: error.toString()),
      loading: () => const _LoadingWidget(),
    );
  }
}

class _PokemonWidget extends StatelessWidget {
  final Pokemon pokemon;

  const _PokemonWidget({required this.pokemon});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(pokemon.name),
        actions: [
          IconButton(
              onPressed: () {
                SharePlugin.shareLink('https://pokemon-linking-website.up.railway.app/pokemons/${pokemon.id}', 'Mira este pokémon');
              },
              icon: const Icon(Icons.share_outlined))
        ],
      ),
      body: Center(
          child: Image.network(
        pokemon.springFront,
        fit: BoxFit.contain,
        width: 150,
        height: 150,
      )),
    );
  }
}

class _ErrorWidget extends StatelessWidget {
  final String message;

  const _ErrorWidget({required this.message});
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Center(child: Text(message)));
  }
}

class _LoadingWidget extends StatelessWidget {
  const _LoadingWidget();
  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: Center(child: CircularProgressIndicator()));
  }
}
