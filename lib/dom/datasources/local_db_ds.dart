import 'package:miscelaneos/dom/dom.dart';

abstract class LocalDbDS {
  Future<List<Pokemon>> pokemons();
  Future<int> count();
  Future<void> insert(Pokemon pokemon);
}
