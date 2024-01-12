import 'package:miscelaneos/dom/dom.dart';

abstract class PokemonsRepository {
  Future<(Pokemon?, String)> getPokemon(String id);
}
