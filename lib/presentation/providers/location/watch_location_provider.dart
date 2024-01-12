import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geolocator/geolocator.dart';

final watchLocationProvider = StreamProvider.autoDispose<(double lat, double lng)>((ref) async* {
  bool serviceEnabled;
  LocationPermission permission;

  serviceEnabled = await Geolocator.isLocationServiceEnabled();
  if (!serviceEnabled) throw 'Location services are disabled.';

  permission = await Geolocator.checkPermission();
  if (permission == LocationPermission.denied) {
    permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) {
      throw 'Location permissions are denied';
    }
  }

  if (permission == LocationPermission.deniedForever) throw 'Location permissions are permanently denied, we cannot request permissions.';

  await for (final location in Geolocator.getPositionStream()) {
    yield (location.latitude, location.longitude);
  }
});
