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

  void setDist(double value) {

  }

  void setPhase(double value) {

  }

  void setFreq(double value) {

  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
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
                  initialValue: '100.0',
                  validator: (String? value) {
                    if (value == null) {
                      return null;
                    }

                    var reg = RegExp('^\\d+([\\.\\,]\\d+)?\$');
                    return reg.hasMatch(value) ? value : null;
                  },
                )),
            Container(
                margin: const EdgeInsets.all(30),
                child: TextFormField(
                  decoration: const InputDecoration(
                      labelText: 'Kąt przesunięcia fazy', suffixText: '°'),
                  initialValue: '360.0',
                  validator: (String? value) {
                    if (value == null) {
                      return null;
                    }

                    var reg = RegExp('^\\d+([\\.\\,]\\d+)?\$');
                    return reg.hasMatch(value) ? value : null;
                  },
                )),
            Container(
                margin: const EdgeInsets.all(30),
                child: TextFormField(
                  decoration: const InputDecoration(
                      labelText: 'Częstotliwość', suffixText: 'Hz'),
                  initialValue: '1',
                  validator: (String? value) {
                    if (value == null) {
                      return null;
                    }

                    var reg = RegExp('^\\d+([\\.\\,]\\d+)?\$');
                    return reg.hasMatch(value) ? value : null;
                  },
                )),
          ],
        ));
  }
}
