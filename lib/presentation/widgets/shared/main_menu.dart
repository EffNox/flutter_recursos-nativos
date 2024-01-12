import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class MenuItem {
  final String title;
  final IconData icon;
  final String route;

  MenuItem(this.title, this.icon, this.route);
}

final menuItems = <MenuItem>[
  MenuItem('Giróscopio', Icons.downloading_outlined, '/gyroscope'),
  MenuItem('Acelerómetro', Icons.speed_outlined, '/accelerometer'),
  MenuItem('Magnetometro', Icons.explore_outlined, '/magnetometer'),
  MenuItem('Giróscopio Ball', Icons.sports_baseball_outlined, '/gyroscope-ball'),
  MenuItem('Brújula', Icons.explore_outlined, '/compass'),
  MenuItem('Pokemons', Icons.catching_pokemon_outlined, '/pokemons'),
  MenuItem('Biométrico', Icons.fingerprint, '/biometric'),
  MenuItem('Mapas', Icons.map_sharp, '/maps'),
  MenuItem('Ubicación', Icons.location_on, '/location'),
  MenuItem('Mapa Controlado', Icons.control_camera_outlined, '/controlled-map'),
  MenuItem('Insignia', Icons.notification_important_outlined, '/badge'),
  MenuItem('Anuncio completo', Icons.ad_units_rounded, '/ad-full'),
  MenuItem('Anuncio recompensado', Icons.fort_sharp, '/ad-rewarded'),
  MenuItem('Proceso en segundo Plano', Icons.storage_rounded, '/db-pokemons'),
];

class MainMenuWidget extends StatelessWidget {
  const MainMenuWidget({super.key});
  @override
  Widget build(BuildContext context) {
    return SliverGrid.count(
      crossAxisCount: 3,
      crossAxisSpacing: 10,
      mainAxisSpacing: 10,
      children: menuItems.map((e) => HomeMenuItemWidget(title: e.title, route: e.route, icon: e.icon)).toList(),
    );
  }
}

class HomeMenuItemWidget extends StatelessWidget {
  final String title;
  final String route;
  final IconData icon;
  final List<Color> bgColors;

  const HomeMenuItemWidget(
      {super.key, required this.title, required this.route, required this.icon, this.bgColors = const [Colors.lightBlueAccent, Colors.blue]});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => context.push(route),
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          gradient: LinearGradient(colors: bgColors),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: Colors.white, size: 65),
            const SizedBox.shrink(),
            Text(
              title,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 16, overflow: TextOverflow.ellipsis, color: Colors.white, fontWeight: FontWeight.bold),
            )
          ],
        ),
      ),
    );
  }
}
