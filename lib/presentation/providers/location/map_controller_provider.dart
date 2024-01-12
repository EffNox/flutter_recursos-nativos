// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapState {
  final bool isReady;
  final bool followUser;
  final List<Marker> markers;
  final GoogleMapController? controller;

  MapState({this.isReady = false, this.followUser = false, this.markers = const [], this.controller});

  Set<Marker> get markersSet {
    return Set.from(markers);
  }

  MapState copyWith({
    bool? isReady,
    bool? followUser,
    List<Marker>? markers,
    GoogleMapController? controller,
  }) {
    return MapState(
      isReady: isReady ?? this.isReady,
      followUser: followUser ?? this.followUser,
      markers: markers ?? this.markers,
      controller: controller ?? this.controller,
    );
  }
}

class MapNotifier extends StateNotifier<MapState> {
  StreamSubscription? userLocation$;

  (double, double)? lastKnownLocation;
  MapNotifier() : super(MapState()) {
    trackuser().listen((event) {
      lastKnownLocation = (event.$1, event.$2);
    });
  }

  Stream<(double, double)> trackuser() async* {
    await for (final pos in Geolocator.getPositionStream()) {
      yield (pos.latitude, pos.longitude);
    }
  }

  void setMapController(GoogleMapController controller) => state = state.copyWith(controller: controller, isReady: true);

  goToLocation(double lat, double lng) {
    final newPosition = CameraPosition(target: LatLng(lat, lng), zoom: 15);
    state.controller?.animateCamera(CameraUpdate.newCameraPosition(newPosition));
  }

  toggleFollowUser() {
    state = state.copyWith(followUser: !state.followUser);
    if (state.followUser) {
      userLocation$ = trackuser().listen((event) => goToLocation(event.$1, event.$2));
    } else {
      userLocation$?.cancel();
    }
  }

  findUser() {
    if (lastKnownLocation == null) return;
    final (lat, lng) = lastKnownLocation!;
    goToLocation(lat, lng);
    // trackuser().take(1).listen((event) => goToLocation(event.$1, event.$2));
  }

  void addMarkerCurrentPosition() {
    final (lat, lng) = lastKnownLocation!;
    addMarker(lat, lng, 'Por aquí pasó el usuario');
  }

  void addMarker(double lat, double lng, String name) {
    final newMarker = Marker(
      markerId: MarkerId('${state.markers.length}'),
      position: LatLng(lat, lng),
      infoWindow: InfoWindow(title: name, snippet: 'Snippet del Window'),
    );
    state = state.copyWith(markers: [...state.markers, newMarker]);
  }
}

final mapControllerProvider = StateNotifierProvider.autoDispose<MapNotifier, MapState>((ref) => MapNotifier());
