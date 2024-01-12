import 'package:flutter_app_badger/flutter_app_badger.dart';

class AppBadgePlugin {
  static Future<bool> get isBadgeSupported => FlutterAppBadger.isAppBadgeSupported();

  static updateBadgeCount(int count) async {
    if (!await isBadgeSupported) {
      // print('No soporta las insignias de APP');
      return;
    }

    FlutterAppBadger.updateBadgeCount(count);
    if (count == 0) removeBadge();
  }

  static void removeBadge() async {
    if (!await isBadgeSupported) {
      print('No soporta las insignias de APP');
      return;
    }
    FlutterAppBadger.removeBadge();
  }
}
