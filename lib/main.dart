import 'dart:math';

import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Przelicznik akustyczny',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.red),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Przelicznik akustyczny'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  double _distance = 100;
  double _phase = 360;
  double _freq = 1;
  static const double waveSpeedOnAir = 343.8; // m/s

  TextEditingController controller1 = TextEditingController(text:'100.0');
  TextEditingController controller2 = TextEditingController(text:'360.0');
  TextEditingController controller3 = TextEditingController(text:'1');

  void setDist(double value) {
    setState(() {
      _distance = value;
      double distancePercentage = _phase / 360;
      double time = ((_distance / 100) / distancePercentage) / waveSpeedOnAir;
      _freq = 1 / time;
    });
  }

  void setPhase(double value) {
    setState(() {
      _phase = value;
      double distancePercentage = _phase / 360;
      double time = ((_distance / 100) / distancePercentage) / waveSpeedOnAir;
      _freq = 1 / time;
    });
  }

  void setFreq(double value) {
    setState(() {
      _freq = value;
      double T = 1 / _freq;
      double fullDist = waveSpeedOnAir * T;

      double distancePercentage = _phase / 360;
      _distance = fullDist * distancePercentage * 100;
    });
  }

  @override
  Widget build(BuildContext context) {
    controller1.text = '$_distance';
    controller2.text = '$_phase';
    controller3.text = '$_freq';

    return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.primary,
          title: Text(widget.title),
        ),
        body: Column(
          children: [
            Container(
                margin: const EdgeInsets.all(30),
                child: const Text(
                    'Formularz pozwalający na przeliczenie odległości przechodzenia fali akustycznej w powietrzu przy temperaturze 20°C.\n')),
            Container(
                margin: const EdgeInsets.all(30),
                child: TextFormField(
                  decoration: const InputDecoration(
                      labelText: 'Odległość', suffixText: 'cm'),
                  validator: (String? value) {
                    if (value == null) {
                      return null;
                    }

                    var reg = RegExp('^\\d+([\\.\\,]\\d+)?\$');
                    return reg.hasMatch(value) ? double.parse(value) > 0 ? value : null : null;
                  },
                  onChanged: (String? value){
                    if(value == null) {
                      return;
                    }

                    double? parsed = double.tryParse(value);
                    if(parsed == null) {
                      return;
                    }

                    setDist(parsed);
                  },
                  controller: controller1,
                )),
            Container(
                margin: const EdgeInsets.all(30),
                child: TextFormField(
                  decoration: const InputDecoration(
                      labelText: 'Kąt przesunięcia fazy', suffixText: '°'),
                  validator: (String? value) {
                    if (value == null) {
                      return null;
                    }

                    var reg = RegExp('^\\d+([\\.\\,]\\d+)?\$');
                    if(!reg.hasMatch(value)) {
                      return null;
                    }

                    double phase = double.parse(value);

                    phase = max(phase, 1);
                    phase = phase % 360.0;
                    return phase.toString();
                  },
                  onChanged: (String? value){
                    if(value == null) {
                      return;
                    }

                    double? parsed = double.tryParse(value);
                    if(parsed == null) {
                      return;
                    }

                    setPhase(parsed);
                  },
                  controller: controller2,
                )),
            Container(
                margin: const EdgeInsets.all(30),
                child: TextFormField(
                  decoration: const InputDecoration(
                      labelText: 'Częstotliwość', suffixText: 'Hz'),
                  validator: (String? value) {
                    if (value == null) {
                      return null;
                    }

                    var reg = RegExp('^\\d+([\\.\\,]\\d+)?\$');
                    return reg.hasMatch(value) ? double.parse(value) > 0 ? value : null : null;
                  },
                  controller: controller3,
                  onChanged: (String? value){
                    if(value == null) {
                      return;
                    }

                    double? parsed = double.tryParse(value);
                    if(parsed == null) {
                      return;
                    }

                    setFreq(parsed);
                  },
                )),
          ],
        ));
  }
}
