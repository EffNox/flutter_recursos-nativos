import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:miscelaneos/config/config.dart';
import 'package:miscelaneos/dom/dom.dart';
import 'package:miscelaneos/presentation/providers/background_tasks/background_tasks_provider.dart';
import 'package:miscelaneos/presentation/providers/providers.dart';
import 'package:workmanager/workmanager.dart';

class DbPokemonsPage extends ConsumerWidget {
  const DbPokemonsPage({super.key});

  @override
  Widget build(BuildContext context, ref) {
    final pokemonsAsync = ref.watch(pokemonDbProvider);
    final isBackgroundFetchActive = ref.watch(backgroundPokemonFetchProvider);
    if (pokemonsAsync.isLoading) return const Scaffold(body: Center(child: CircularProgressIndicator()));
    final pokemons = pokemonsAsync.value ?? [];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Background Process'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add_alarm_sharp),
            onPressed: () {
              Workmanager().registerOneOffTask(
                fetchBackgroundTaskKey,
                fetchBackgroundTaskKey,
                initialDelay: const Duration(seconds: 3),
                inputData: {'data': 45},
              );
            },
          ),
        ],
      ),
      body: CustomScrollView(
        slivers: [
          _PokemonsGridWidget(pokemons: pokemons),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        label: Text('${(isBackgroundFetchActive == true) ? 'Desactivar' : 'Activar'} fetch periódico'),
        icon: const Icon(Icons.av_timer),
        onPressed: () {
          ref.read(backgroundPokemonFetchProvider.notifier).toggleProcess();
        },
      ),
    );
  }
}

class _PokemonsGridWidget extends StatelessWidget {
  final List<Pokemon> pokemons;
  const _PokemonsGridWidget({required this.pokemons});
  @override
  Widget build(BuildContext context) {
    return SliverGrid.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3, crossAxisSpacing: 2, mainAxisSpacing: 2),
      itemCount: pokemons.length,
      itemBuilder: (context, index) {
        final v = pokemons[index];
        return Column(
          children: [
            Image.network(
              v.springFront,
              fit: BoxFit.contain,
            ),
            Text(v.name),
          ],
        );
      },
    );
  }
}
