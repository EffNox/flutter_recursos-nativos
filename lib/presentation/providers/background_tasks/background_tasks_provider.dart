import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:miscelaneos/config/config.dart';
import 'package:workmanager/workmanager.dart';

class BackgroundFetchNotifier extends StateNotifier<bool?> {
  final String processKeyName;
  BackgroundFetchNotifier({required this.processKeyName}) : super(false) {
    checkCurrentStatus();
  }

  void checkCurrentStatus() async {
    state = await SharedPreferencesPlugin.getBool(processKeyName) ?? false;
  }

  toggleProcess() {
    if (state == true) {
      deactiveProcess();
    } else {
      activateProcess();
    }
  }

  activateProcess() async {
    await Workmanager().registerPeriodicTask(
      processKeyName,
      processKeyName,
      frequency: const Duration(seconds: 10), //lo cambiará a 15 minutos
      constraints: Constraints(
        networkType: NetworkType.connected,
      ),
      tag: processKeyName,
      // inputData:
    );
    await SharedPreferencesPlugin.setBool(processKeyName, true);
    state = true;
  }

  deactiveProcess() async {
    await Workmanager().cancelByTag(processKeyName);
    await SharedPreferencesPlugin.setBool(processKeyName, false);
    state = false;
  }
}

final backgroundPokemonFetchProvider = StateNotifierProvider<BackgroundFetchNotifier, bool?>((ref) {
  return BackgroundFetchNotifier(processKeyName: fetchPeriodicBackgroundTaskKey);
});
