import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:miscelaneos/dom/dom.dart';
import 'package:miscelaneos/infra/infra.dart';

final pokemonsRepositoryProvider = Provider<PokemonsRepository>((ref) => PokemonsRepositoryImpl());

final pokemonProvider = FutureProvider.family<Pokemon, String>((ref, id) async {
  final pokemonRepository = ref.watch(pokemonsRepositoryProvider);
  final (pokemon, error) = await pokemonRepository.getPokemon(id);

  // await Future.delayed(const Duration(seconds: 2));

  if (pokemon != null) return pokemon;

  throw error;
});
