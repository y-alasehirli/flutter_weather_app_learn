import 'package:flutter/material.dart';
import 'package:flutter33_hava_durumu_app/models/weather_model.dart';
import 'package:flutter33_hava_durumu_app/pages/riverpod_main_page.dart';
import 'package:flutter33_hava_durumu_app/pods/weather_model_pod.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'pages/bloc_main_page.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'bloc/weather_bloc.dart';
import 'const/interval_tools.dart';

void main() {
  setupLocator();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Hava Durumu App',
      home: MainApp(),
    );
  }
}

class MainApp extends StatelessWidget {
  const MainApp({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Hava Durumu App'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => BlocProvider(
                              create: (context) => WeatherBloc(),
                              child: const BlocMainPage())));
                },
                child: const Text('Bloc Yapısı İle Hava Durumu')),
            ElevatedButton(
                style: ElevatedButton.styleFrom(primary: Colors.green),
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              const ProviderScope(child: RiverPodMainPage())));
                },
                child: const Text('Riverpod İle Hava Durumu')),
          ],
        ),
      ),
    );
  }
}
