import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter33_hava_durumu_app/const/interval_tools.dart';
import 'package:flutter33_hava_durumu_app/models/weather_model.dart';
import 'package:flutter33_hava_durumu_app/pods/weather_model_pod.dart';
import 'package:flutter33_hava_durumu_app/widgets/high_low_temp_widget.dart';
import 'package:flutter33_hava_durumu_app/widgets/now_temp_widget.dart';
import 'package:flutter33_hava_durumu_app/widgets/search_app_bar_riverpod.dart';
import 'package:flutter33_hava_durumu_app/widgets/title_text_widget.dart';
import 'package:flutter33_hava_durumu_app/widgets/updated_time_widget.dart';
import 'package:flutter33_hava_durumu_app/widgets/weather_image_widget.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class RiverPodMainPage extends ConsumerWidget {
  const RiverPodMainPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const MaterialApp(
      home: Scaffold(
        appBar: SearchAppBarPod(),
        body: RiverPodBody(),
      ),
    );
  }
}

class RiverPodBody extends ConsumerWidget {
  const RiverPodBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Completer _refreshCompleter = Completer();
    WeatherPState watch = ref.watch(weatherProvider);
    Weather? weather = ref.read(weatherProvider.notifier).weather;
    if (watch == WeatherPState.initial) {
      print(watch.toString());
      return const Center(
        child: Text("Lütfen şehir aratın"),
      );
    } else if (watch == WeatherPState.loading) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    } else if (watch == WeatherPState.idle) {
      return LoadedPage();
    } else if (watch == WeatherPState.loaded) {
      return RefreshIndicator(
          child: LoadedPage(),
          onRefresh: () {
            ref.read(weatherProvider.notifier).refreshWeather(weather!.title);
            return _refreshCompleter.future;
          });
    } else {
      return const Center(
        child: Text("Hata oluştu"),
      );
    }
    /* switch (pState) {
      case WeatherPState.initial:
        print(pState.toString());
        return const Center(
          child: Text("Lütfen şehir aratın"),
        );
      case WeatherPState.loading:
        print(pState.toString());
        return const Center(
          child: CircularProgressIndicator(),
        );
      case WeatherPState.error:
        print(pState.toString());
        return const Center(
          child: Text("Hata oluştu"),
        );
      case WeatherPState.loaded:
        print(pState.toString());
        return LoadedPage();
    } */
  }
}


// Refresh Indicator Sürekli tetikliyor. RefreshIndicitor kullanımı doğru değil. Gerekli güncellemeler ileri de yapılabilir. Öenmli olan bloc-state / Riverpod kullanımları. 
class LoadedPage extends ConsumerWidget {
  LoadedPage({Key? key}) : super(key: key);
  Completer _refreshCompleter = Completer();
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    print("loaded tetiklendi");
    _refreshCompleter.complete();
    _refreshCompleter = Completer();
    Weather? weather = ref.read(weatherProvider.notifier).weather;
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView(
          /*  mainAxisAlignment: MainAxisAlignment.start, */
          children: [
            Column(
              children: [
                TitleWidget(title: weather!.title),
                UpdatedTimeWidget(updateTime: weather.time),
                NowTempWidget(temp: weather.consolidatedWeather[0].theTemp),
                ImageWidget(
                    stateAbbr: weather.consolidatedWeather[0].weatherStateAbbr),
                HighLowTempWidget(
                  maxTemp: weather.consolidatedWeather[0].maxTemp,
                  minTemp: weather.consolidatedWeather[0].minTemp,
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
