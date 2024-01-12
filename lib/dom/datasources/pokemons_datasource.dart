import 'package:miscelaneos/dom/dom.dart';

abstract class PokemonsDatasource {
  Future<(Pokemon?, String)> getPokemon(String id);
}
