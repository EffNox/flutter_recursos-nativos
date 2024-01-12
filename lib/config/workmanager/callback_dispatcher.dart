import 'package:miscelaneos/infra/infra.dart';
import 'package:workmanager/workmanager.dart';

const fetchBackgroundTaskKey = 'com.effnox.miscelaneos.simpleTask.fetch-background-pokemon';
const fetchPeriodicBackgroundTaskKey = 'com.effnox.miscelaneos.simpleTask.fetch-background-pokemon';

@pragma('vm:entry-point')
void callbackDispatcher() {
  Workmanager().executeTask((task, inputData) async {
    switch (task) {
      case fetchBackgroundTaskKey:
        await loadNextPokemon();
        break;
      case fetchPeriodicBackgroundTaskKey:
        await loadNextPokemon();
        break;
      case Workmanager.iOSBackgroundTask:
        print('iOSBackgroundTask: ');

        break;
      default:
    }

    // print("Native called background task: $task");
    return true;
  });
}

Future loadNextPokemon() async {
  final localDbRepo = LocalDbRepositoryImpl();
  final pokemonRepo = PokemonsRepositoryImpl();
  final lastPokemonId = await localDbRepo.count() + 1;
  try {
    final (pokemon, msg) = await pokemonRepo.getPokemon('$lastPokemonId');
    if (pokemon == null) throw msg;

    await localDbRepo.insert(pokemon);
    print('${pokemon.name} inserted');
  } catch (e) {
    print('e: $e');
  }
}
