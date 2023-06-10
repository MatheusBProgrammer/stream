import 'package:my_app/events/end_event.dart';
import 'package:my_app/events/exercicio_event.dart';
import 'package:my_app/events/start_event.dart';

import '../events/treino_event.dart';
import '../models/treino.dart';

class TreinoController {
  List<Treino> treinoTimers;

  TreinoController({required this.treinoTimers});

  Stream<TreinoEvent> start() async* {
    yield StartEvent();
    for (Treino treino in treinoTimers) {
      for(int seconds = treino.seconds; seconds >= 0; seconds--){
        await Future.delayed(Duration(seconds: 1));
        yield ExercicioEvent(treino: treino, now: seconds);
      }

    }

    yield EndEvent();
  }
}
