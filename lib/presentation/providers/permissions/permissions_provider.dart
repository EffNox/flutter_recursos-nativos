import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:permission_handler/permission_handler.dart';

final permissionsProvider = StateNotifierProvider<PermissionsNotifier, PermissionState>((ref) => PermissionsNotifier());

class PermissionsNotifier extends StateNotifier<PermissionState> {
  PermissionsNotifier() : super(PermissionState()); // {  checkPermissions();}

  Future<void> checkPermissions() async {
    final permissionsList = await Future.wait([
      Permission.camera.status,
      Permission.photos.status,
      Permission.sensors.status,
      //
      Permission.location.status,
      Permission.locationAlways.status,
      Permission.locationWhenInUse.status,
    ]);

    state = state.copyWith(
      camera: permissionsList[0],
      photoLibrary: permissionsList[1],
      sensors: permissionsList[2],
      location: permissionsList[3],
      locationAlways: permissionsList[4],
      locationWhenInUse: permissionsList[5],
    );
  }

  requestCameraAccess() async {
    final status = await Permission.camera.request();
    state = state.copyWith(camera: status);
    if (status == PermissionStatus.permanentlyDenied) openAppSettings();
  }

  requestPhotoLibraryAccess() async {
    final status = await Permission.photos.request();
    state = state.copyWith(photoLibrary: status);
    if (status == PermissionStatus.permanentlyDenied) openAppSettings();
  }

  requestSensorsAccess() async {
    final status = await Permission.sensors.request();
    state = state.copyWith(sensors: status);
    if (status == PermissionStatus.permanentlyDenied) openAppSettings();
  }

  requestLocationAccess() async {
    final status = await Permission.location.request();
    state = state.copyWith(location: status);
    if (status == PermissionStatus.permanentlyDenied) openAppSettings();
  }
}

class PermissionState {
  final PermissionStatus camera;
  final PermissionStatus photoLibrary;
  final PermissionStatus sensors;

  final PermissionStatus location;
  final PermissionStatus locationAlways;
  final PermissionStatus locationWhenInUse;

  PermissionState(
      {this.camera = PermissionStatus.denied,
      this.photoLibrary = PermissionStatus.denied,
      this.sensors = PermissionStatus.denied,
      this.location = PermissionStatus.denied,
      this.locationAlways = PermissionStatus.denied,
      this.locationWhenInUse = PermissionStatus.denied});

  bool get cameraGranted => camera == PermissionStatus.granted;
  bool get photoLibraryGranted => photoLibrary == PermissionStatus.granted;
  bool get sensorsGranted => sensors == PermissionStatus.granted;
  bool get locationGranted => location == PermissionStatus.granted;
  bool get locationAlwaysGranted => locationAlways == PermissionStatus.granted;
  bool get locationWhenInUseGranted => locationWhenInUse == PermissionStatus.granted;

  PermissionState copyWith({
    PermissionStatus? camera,
    PermissionStatus? photoLibrary,
    PermissionStatus? sensors,
    PermissionStatus? location,
    PermissionStatus? locationAlways,
    PermissionStatus? locationWhenInUse,
  }) =>
      PermissionState(
        camera: camera ?? this.camera,
        photoLibrary: photoLibrary ?? this.photoLibrary,
        sensors: sensors ?? this.sensors,
        location: location ?? this.location,
        locationAlways: locationAlways ?? this.locationAlways,
        locationWhenInUse: locationWhenInUse ?? this.locationWhenInUse,
      );
}
