import 'package:go_router/go_router.dart';
import 'package:miscelaneos/presentation/pages/pages.dart';

// GoRouter get appRouter => GoRouter(
//       // initialLocation: '/pokemons',
//       routes: [
//         GoRoute(path: '/', builder: (_, __) => const HomePage()),
//         GoRoute(path: '/permissions', builder: (_, __) => const PermissionsPage()),

//         GoRoute(path: '/gyroscope', builder: (_, __) => const GyroscopePage()),
//         GoRoute(path: '/accelerometer', builder: (_, __) => const AccelerometerPage()),
//         GoRoute(path: '/magnetometer', builder: (_, __) => const MagnetometerPage()),
//         GoRoute(path: '/gyroscope-ball', builder: (_, __) => const GyroscopeBallPage()),
//         GoRoute(path: '/compass', builder: (_, __) => const CompassPage()),

//         GoRoute(
//           path: '/pokemons',
//           builder: (_, __) => const PokemonsPage(),
//           routes: [
//             GoRoute(
//               path: ':id',
//               builder: (_, st) {
//                 final id = st.pathParameters['id'] ?? '1';
//                 return PokemonPage(pokemonId: id);
//               },
//             ),
//           ],
//         ),

//         GoRoute(path: '/biometric', builder: (_, __) => const BiometricPage()),

//         GoRoute(path: '/maps', builder: (_, __) => const MapPage()),
//         GoRoute(path: '/location', builder: (_, __) => const LocationPage()),
//         GoRoute(path: '/controlled-map', builder: (_, __) => const ControlledMapPage()),
//         // GoRoute(name: Routes.movie, path: '/movie/:id', builder: (_, st) => MoviePage(movieId: int.parse(st.pathParameters['id']!))),
//       ],
//       // errorBuilder: (context, state) => MaterialPageRoute(builder: (_) => Scaffold(body: Center(child: Assets.svgs.error404.svg()))),
//     );
final appRouter = GoRouter(
  // initialLocation: '/pokemons',
  routes: [
    GoRoute(path: '/', builder: (_, __) => const HomePage()),
    GoRoute(path: '/permissions', builder: (_, __) => const PermissionsPage()),

    GoRoute(path: '/gyroscope', builder: (_, __) => const GyroscopePage()),
    GoRoute(path: '/accelerometer', builder: (_, __) => const AccelerometerPage()),
    GoRoute(path: '/magnetometer', builder: (_, __) => const MagnetometerPage()),
    GoRoute(path: '/gyroscope-ball', builder: (_, __) => const GyroscopeBallPage()),
    GoRoute(path: '/compass', builder: (_, __) => const CompassPage()),

    GoRoute(
      path: '/pokemons',
      builder: (_, __) => const PokemonsPage(),
      routes: [
        GoRoute(
          path: ':id',
          builder: (_, st) {
            final id = st.pathParameters['id'] ?? '1';
            return PokemonPage(pokemonId: id);
          },
        ),
      ],
    ),

    GoRoute(path: '/biometric', builder: (_, __) => const BiometricPage()),

    GoRoute(path: '/maps', builder: (_, __) => const MapPage()),
    GoRoute(path: '/location', builder: (_, __) => const LocationPage()),
    GoRoute(path: '/controlled-map', builder: (_, __) => const ControlledMapPage()),
    GoRoute(path: '/badge', builder: (_, __) => const BadgePage()),
    GoRoute(path: '/ad-full', builder: (_, __) => const AdFullPage()),
    GoRoute(path: '/ad-rewarded', builder: (_, __) => const AdRewardedPage()),
    GoRoute(path: '/db-pokemons', builder: (_, __) => const DbPokemonsPage()),
    // GoRoute(name: Routes.movie, path: '/movie/:id', builder: (_, st) => MoviePage(movieId: int.parse(st.pathParameters['id']!))),
  ],
  // errorBuilder: (context, state) => MaterialPageRoute(builder: (_) => Scaffold(body: Center(child: Assets.svgs.error404.svg()))),
);
