import 'package:flutter/material.dart';
import 'package:my_app/controllers/treino_controller.dart';
import 'package:my_app/events/end_event.dart';
import 'package:my_app/events/exercicio_event.dart';
import 'package:my_app/events/treino_event.dart';

import 'components/counter.dart';
import 'events/start_event.dart';
import 'models/treino.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _MyAppState();
}

class _MyAppState extends State<HomePage> {
  bool showStartButton = true;

  late final TreinoController controller;
  late final Stream<TreinoEvent> treinoStream;

  //this function uses a stream to listen to the events
  //the stream works like a listener, it will listen to the events and do something when it receives an event
  start() {
    controller = TreinoController(treinoTimers: [
      Treino(name: 'Flexão', seconds: 10),
      Treino(name: 'Prancha', seconds: 50),
      Treino(name: 'Agachamento', seconds: 60),
      Treino(name: 'Descanso', seconds: 60),
      Treino(name: 'Elevação Lateral', seconds: 10),
    ]);

    setState(() {
      treinoStream = controller.start();
      showStartButton = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: showStartButton
          ? ElevatedButton(
              onPressed: start,
              child: Text('Iniciar Treino'),
            )
          : StreamBuilder(
              stream: treinoStream,
              builder: (_, AsyncSnapshot<TreinoEvent> snapshot) {
                TreinoEvent? event = snapshot.data;
                if (snapshot.hasError) {
                  return Text('Erro ao iniciar o treino');
                } else if (event is StartEvent) {
                  return const Text('Iniciando treino...');
                } else if (event is EndEvent) {
                  return const Text('Treino encerrado');
                } else if (event is ExercicioEvent) {
                  return Counter(event: event);
                } else {
                  return CircularProgressIndicator();
                }
              }),
    ));
  }
}
