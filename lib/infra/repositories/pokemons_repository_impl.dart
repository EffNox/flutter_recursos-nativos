import 'package:miscelaneos/dom/dom.dart';
import 'package:miscelaneos/infra/infra.dart';

class PokemonsRepositoryImpl implements PokemonsRepository {
  final PokemonsDatasource datasource;

  // PokemonsRepositoryImpl(this.datasource);
  PokemonsRepositoryImpl({PokemonsDatasource? datasource}) : datasource = datasource ?? PokemonsDatasourceImpl();

  @override
  Future<(Pokemon?, String)> getPokemon(String id) async {
    return datasource.getPokemon(id);
  }
}
