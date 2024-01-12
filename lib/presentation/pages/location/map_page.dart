import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:miscelaneos/presentation/providers/providers.dart';

class MapPage extends ConsumerWidget {
  const MapPage({super.key});

  @override
  Widget build(BuildContext context, ref) {
    final currentPositionAsync = ref.watch(userLocationProvider);
    return Scaffold(
      appBar: AppBar(),
      body: currentPositionAsync.when(
        data: (v) => _MapWidget(lat: v.$1, lng: v.$2),
        error: (error, _) => Text('$error'),
        loading: () => const CircularProgressIndicator(),
      ),
    );
  }
}

class _MapWidget extends StatefulWidget {
  final double lat;
  final double lng;
  const _MapWidget({required this.lat, required this.lng});

  @override
  State<_MapWidget> createState() => _MapWidgetState();
}

class _MapWidgetState extends State<_MapWidget> {
  @override
  Widget build(BuildContext context) {
    return GoogleMap(
      mapType: MapType.hybrid,
      initialCameraPosition: CameraPosition(target: LatLng(widget.lat, widget.lng), zoom: 12),
      onMapCreated: (controller) {},
    );
  }
}
