import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:miscelaneos/presentation/providers/providers.dart';

class GyroscopeBallPage extends ConsumerWidget {
  const GyroscopeBallPage({super.key});

  @override
  Widget build(BuildContext context, ref) {
    final gyroscope$ = ref.watch(gyroscopeProvider);
    return Scaffold(
      appBar: AppBar(title: const Text('GiróscopioPage')),
      body: SizedBox.expand(
        child: gyroscope$.when(
          data: (v) => MovingBallWidget(x: v.x, y: v.y),
          error: (error, stackTrace) => Text('$error'),
          loading: () => const CircularProgressIndicator(),
        ),
      ),
    );
  }
}

class MovingBallWidget extends StatelessWidget {
  final double x;
  final double y;

  const MovingBallWidget({super.key, required this.x, required this.y});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    double screenWidth = size.width;
    // double screenHeight = size.height;

    double currentYPos = (y * 150);
    // double currentXPos = (x * 100);

    return Stack(
      alignment: Alignment.center,
      children: [
        AnimatedPositioned(
          left: (currentYPos - 25) + (screenWidth / 2),
          curve: Curves.easeInOut,
          duration: const Duration(seconds: 1),
          child: const BallWidget(),
        ),
        Text('''
currentYPos:$currentYPos
X: $x
Y: $y
''', style: const TextStyle(fontSize: 40)),
      ],
    );
  }
}

class BallWidget extends StatelessWidget {
  const BallWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 50,
      height: 50,
      decoration: BoxDecoration(color: Colors.blue, borderRadius: BorderRadius.circular(100)),
    );
  }
}
