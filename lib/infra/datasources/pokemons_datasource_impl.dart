import 'package:dio/dio.dart';
import 'package:miscelaneos/dom/dom.dart';
import 'package:miscelaneos/infra/mappers/pokemon_mapper.dart';

class PokemonsDatasourceImpl implements PokemonsDatasource {
  final dio = Dio(BaseOptions(baseUrl: 'https://pokeapi.co/api/v2'));

  @override
  Future<(Pokemon?, String)> getPokemon(String id) async {
    try {
      final rs = await dio.get('/pokemon/$id');
      final pokemon = PokemonMapper.toEntity(rs.data);
      return (pokemon, 'Datos obtenidos correctamente');
    } catch (e) {
      return (null, 'No se pudo obtener el pokémon $e');
    }
  }
}
