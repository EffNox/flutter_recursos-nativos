import 'package:miscelaneos/dom/dom.dart';
import 'package:miscelaneos/infra/models/pokemon_api_response.dart';

class PokemonMapper {
  static Pokemon toEntity(Map<String, dynamic> json) {
    final pokemonApiResponse = PokemonApiResponse.fromJson(json);
    return Pokemon(id: pokemonApiResponse.id, name: pokemonApiResponse.name, springFront: pokemonApiResponse.sprites.frontDefault);
  }
}
