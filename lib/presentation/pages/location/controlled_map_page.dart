import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:miscelaneos/presentation/providers/providers.dart';

class ControlledMapPage extends ConsumerWidget {
  const ControlledMapPage({super.key});

  @override
  Widget build(BuildContext context, ref) {
    final userInitialLocation = ref.watch(userLocationProvider);
    return Scaffold(
      body: userInitialLocation.when(
        data: (data) => MapAndControlsWidget(lat: data.$1, lng: data.$2),
        error: (error, _) => Text('$error'),
        loading: () => const Center(child: Text('Ubicando usuario')),
      ),
    );
  }
}

class MapAndControlsWidget extends ConsumerWidget {
  final double lat;
  final double lng;
  const MapAndControlsWidget({super.key, required this.lat, required this.lng});

  @override
  Widget build(BuildContext context, ref) {
    final mapControllerState = ref.watch(mapControllerProvider);

    return Stack(
      children: [
        MapWidget(lat: lat, lng: lng),
        Positioned(
          child: IconButton.filledTonal(onPressed: () => context.pop(), icon: const Icon(Icons.arrow_back_ios)),
        ),
        Positioned(
          bottom: 40,
          left: 20,
          child: IconButton.filledTonal(
            icon: const Icon(Icons.location_searching),
            onPressed: () => ref.read(mapControllerProvider.notifier).goToLocation(lat, lng),
          ),
        ),
        Positioned(
          bottom: 90,
          left: 20,
          child: IconButton.filledTonal(
            onPressed: () => ref.read(mapControllerProvider.notifier).toggleFollowUser(),
            icon: Icon(mapControllerState.followUser ? Icons.directions_run : Icons.accessibility_new_outlined),
          ),
        ),
        Positioned(
          bottom: 140,
          left: 20,
          child: IconButton.filledTonal(
            onPressed: () {
              // ref.read(mapControllerProvider.notifier).findUser();
              ref.read(mapControllerProvider.notifier).addMarkerCurrentPosition();
            },
            icon: const Icon(Icons.pin_drop),
          ),
        ),
      ],
    );
  }
}

class MapWidget extends ConsumerStatefulWidget {
  final double lat;
  final double lng;

  const MapWidget({super.key, required this.lat, required this.lng});

  @override
  _MapWidgetState createState() => _MapWidgetState();
}

class _MapWidgetState extends ConsumerState<MapWidget> {
  @override
  Widget build(BuildContext context) {
    final mapController = ref.watch(mapControllerProvider);

    return GoogleMap(
      markers: mapController.markersSet,
      mapType: MapType.hybrid,
      initialCameraPosition: CameraPosition(target: LatLng(widget.lat, widget.lng), zoom: 12),
      myLocationEnabled: true,
      zoomControlsEnabled: false,
      myLocationButtonEnabled: false,
      onMapCreated: (controller) => ref.read(mapControllerProvider.notifier).setMapController(controller),
      onLongPress: (gps) {
        ref.read(mapControllerProvider.notifier).addMarker(gps.latitude, gps.longitude, 'Custom Marker');
      },
    );
  }
}
