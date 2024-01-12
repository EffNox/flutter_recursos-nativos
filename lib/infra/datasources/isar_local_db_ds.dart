import 'package:isar/isar.dart';
import 'package:miscelaneos/dom/dom.dart';
import 'package:path_provider/path_provider.dart';

class IsarLocalDbDs extends LocalDbDS {
  late Future<Isar> db;
  IsarLocalDbDs() {
    db = openDb();
  }

  @override
  Future<int> count() async {
    final isar = await db;
    return isar.pokemons.count();
  }

  @override
  Future<void> insert(Pokemon pokemon) async {
    final isar = await db;
    /* final done = */ isar.writeTxnSync(() => isar.pokemons.putSync(pokemon));
  }

  @override
  Future<List<Pokemon>> pokemons() async {
    final isar = await db;
    return isar.pokemons.where().findAll();
  }

  Future<Isar> openDb() async {
    final dir = await getApplicationDocumentsDirectory();
    if (Isar.instanceNames.isEmpty) return await Isar.open([PokemonSchema], directory: dir.path);
    return Future.value(Isar.getInstance());
  }
}
