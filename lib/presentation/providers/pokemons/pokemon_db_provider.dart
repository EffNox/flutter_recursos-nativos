import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:miscelaneos/dom/dom.dart';
import 'package:miscelaneos/infra/infra.dart';

final pokemonDbProvider = FutureProvider.autoDispose<List<Pokemon>>((ref) async {
  final db = LocalDbRepositoryImpl();
  return await db.pokemons();
});
