import 'package:flutter/material.dart';
import 'package:my_app/events/exercicio_event.dart';

class Counter extends StatelessWidget {
  final ExercicioEvent event;

  const Counter({super.key, required this.event});

  getColor(int now, int limit) {
    double percent = now / limit;
    if (percent > 0.5) {
      return Colors.green;
    } else if (percent > 0.25) {
      return Colors.yellow;
    } else {
      return Colors.red;
    }
  }

  @override
  Widget build(BuildContext context) {
    final treino = event.treino;

    return Stack(alignment: Alignment.center, children: [
      Container(
          width: 200,
          height: 200,
          child: CircularProgressIndicator(
            value: event.now / treino.seconds,
            valueColor:
                AlwaysStoppedAnimation(getColor(event.now, treino.seconds)),
            strokeWidth: 5,
          )),
      Text('${event.now}',
          style: const TextStyle(fontSize: 50, fontWeight: FontWeight.bold)),
      Positioned(
        bottom: 50,
        child: Text('${treino.name}',
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
      )
    ]);
  }
}
