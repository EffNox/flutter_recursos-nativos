import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:miscelaneos/presentation/providers/providers.dart';

class PermissionsPage extends StatelessWidget {
  const PermissionsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(), body: const _PermissionsViewWidget());
  }
}

class _PermissionsViewWidget extends ConsumerWidget {
  const _PermissionsViewWidget();
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // final appState = ref.watch(appStateProvider);
    final permissions = ref.watch(permissionsProvider);
    final showAds = ref.watch(showAdsProvider);

    return ListView(
      children: [
        SwitchListTile(
          value: permissions.cameraGranted,
          title: const Text('Cámara'),
          subtitle: Text('${permissions.camera}'),
          onChanged: (_) {
            ref.read(permissionsProvider.notifier).requestCameraAccess();
          },
        ),
        SwitchListTile(
          value: permissions.photoLibraryGranted,
          title: const Text('Galería de fotos'),
          subtitle: Text('${permissions.photoLibrary}'),
          onChanged: (_) {
            ref.read(permissionsProvider.notifier).requestPhotoLibraryAccess();
          },
        ),
        SwitchListTile(
          value: permissions.locationGranted,
          title: const Text('Localización'),
          subtitle: Text('${permissions.location}'),
          onChanged: (_) {
            ref.read(permissionsProvider.notifier).requestLocationAccess();
          },
        ),
        SwitchListTile(
          value: permissions.sensorsGranted,
          title: const Text('Sensores'),
          subtitle: Text('${permissions.sensors}'),
          onChanged: (_) {
            ref.read(permissionsProvider.notifier).requestSensorsAccess();
          },
        ),
        SwitchListTile(
          value: showAds,
          title: const Text('Mostrar publicidad'),
          subtitle: const Text('Esta opción muestra y oculta publicidad'),
          onChanged: (_) {
            ref.read(showAdsProvider.notifier).toggleAds();
          },
        ),
        // ListTile(title: Text('Estado actual: $appState')),
      ],
    );
  }
}
