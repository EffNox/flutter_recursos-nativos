import 'package:miscelaneos/config/config.dart';
import 'package:quick_actions/quick_actions.dart';

class QuickActionsPlugin {
  static registerActions() {
    const quickActions = QuickActions();
    quickActions.initialize((type) {
      final location = switch (type) {
        'biometric' => '/biometric',
        'compass' => '/compass',
        'pokemons' => '/pokemons',
        'charmander' => '/pokemons/4',
        _ => '/',
      };

      appRouter.push(location);
    });

    quickActions.setShortcutItems(<ShortcutItem>[
      const ShortcutItem(type: 'biometric', localizedTitle: 'Biometric', icon: 'finger'),
      const ShortcutItem(type: 'compass', localizedTitle: 'Compass', icon: 'compass'),
      const ShortcutItem(type: 'pokemons', localizedTitle: 'Pokemons', icon: 'pokemons'),
      const ShortcutItem(type: 'charmander', localizedTitle: 'Charmander', icon: 'charmander'),
    ]);
  }
}
