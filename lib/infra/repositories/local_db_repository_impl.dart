import 'package:miscelaneos/dom/dom.dart';
import 'package:miscelaneos/infra/datasources/isar_local_db_ds.dart';

class LocalDbRepositoryImpl extends LocalDbRepository {
  final LocalDbDS _dbDS;

  LocalDbRepositoryImpl([LocalDbDS? dbDS]) : _dbDS = dbDS ?? IsarLocalDbDs();

  @override
  Future<int> count() {
    return _dbDS.count();
  }

  @override
  Future<void> insert(Pokemon pokemon) {
    return _dbDS.insert(pokemon);
  }

  @override
  Future<List<Pokemon>> pokemons() {
    return _dbDS.pokemons();
  }
}
