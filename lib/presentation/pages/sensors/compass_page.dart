import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:miscelaneos/presentation/pages/pages.dart';
import 'package:miscelaneos/presentation/providers/providers.dart';

class CompassPage extends ConsumerWidget {
  const CompassPage({super.key});

  @override
  Widget build(BuildContext context, ref) {
    final locationGranted = ref.watch(permissionsProvider).locationGranted;

    if (!locationGranted) return const AskLocationPage();
    final compassHeading$ = ref.watch(compassProvider);

    return Scaffold(
      appBar: AppBar(
          title: const Text('CompassPage', style: TextStyle(color: Colors.white)),
          backgroundColor: Colors.black,
          iconTheme: const IconThemeData(color: Colors.white)),
      backgroundColor: Colors.black,
      body: Center(
          child: compassHeading$.when(
        data: (v) => CompassWidget(heading: v ?? 0),
        error: (error, stackTrace) => Text('$error', style: const TextStyle(color: Colors.white)),
        loading: () => const CircularProgressIndicator(),
      )),
    );
  }
}

class CompassWidget extends StatefulWidget {
  final double heading;
  const CompassWidget({super.key, required this.heading});

  @override
  State<CompassWidget> createState() => _CompassWidgetState();
}

class _CompassWidgetState extends State<CompassWidget> {
  double prevValue = 0.0;
  double turns = 0;

  double getTurns() {
    double? direction = widget.heading;
    direction = (direction < 0) ? (360 + direction) : direction;

    double diff = direction - prevValue;
    if (diff.abs() > 180) {
      if (prevValue > direction) {
        diff = 360 - (direction - prevValue).abs();
      } else {
        diff = 360 - (prevValue - direction).abs();
        diff = diff * -1;
      }
    }

    turns += (diff / 360);
    prevValue = direction;

    return turns * -1;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        // Text('${widget.heading.ceil()}', style: const TextStyle(color: Colors.white, fontSize: 30)),
        // const SizedBox(height: 20),
        Stack(
          alignment: Alignment.center,
          children: [
            // Image.asset('assets/img/compass/quadrant-3.png'),
            // Transform.rotate(
            //   angle: (heading * (pi / 180) * -1),
            //   child: Image.asset('assets/img/compass/needle-1.png'),
            // ),
            // AnimatedRotation(
            //   curve: Curves.easeOut,
            //   turns: getTurns(),
            //   duration: const Duration(seconds: 1),
            //   child: Image.asset('assets/img/compass/needle-1.png'),
            // )

            AnimatedRotation(
              curve: Curves.easeOut,
              turns: getTurns(),
              duration: const Duration(seconds: 1),
              child: Image.asset('assets/img/compass/quadrant-3.png'),
            ),
            Image.asset('assets/img/compass/needle-1.png')
          ],
        )
      ],
    );
  }
}
