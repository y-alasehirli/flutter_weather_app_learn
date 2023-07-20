import 'dart:async';
import 'package:flutter/material.dart';
import '/widgets/high_low_temp_widget.dart';
import '/widgets/now_temp_widget.dart';
import '/widgets/title_text_widget.dart';
import '/widgets/updated_time_widget.dart';
import '/widgets/weather_image_widget.dart';
import '/bloc/weather_bloc.dart';
import '/widgets/search_app_bar.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BlocMainPage extends StatelessWidget {
  const BlocMainPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print("genel context calıştı");
    Completer<void> _refreshCompleter = Completer<void>();
    return MaterialApp(
      home: Scaffold(
          appBar: const SearchAppBar(),
          body:
              BlocBuilder<WeatherBloc, WeatherState>(builder: (context, state) {
            if (state is WeatherInitial) {
              return const Center(
                child: Text("Lütfen şehir aratın"),
              );
            } else if (state is WeatherLoadedState) {
              print("loaded context calıştı");
              _refreshCompleter.complete();
              _refreshCompleter = Completer();
              return RefreshIndicator(
                onRefresh: () {
                  context
                      .read<WeatherBloc>()
                      .add(RefreshWeatherEvent(sehir: state.weather.title));
                  return _refreshCompleter.future;
                },
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ListView(
                      /*  mainAxisAlignment: MainAxisAlignment.start, */
                      children: [
                        Column(
                          children: [
                            TitleWidget(title: state.weather.title),
                            UpdatedTimeWidget(updateTime: state.weather.time),
                            NowTempWidget(
                                temp: state
                                    .weather.consolidatedWeather[0].theTemp),
                            ImageWidget(
                                stateAbbr: state.weather.consolidatedWeather[0]
                                    .weatherStateAbbr),
                            HighLowTempWidget(
                              maxTemp:
                                  state.weather.consolidatedWeather[0].maxTemp,
                              minTemp:
                                  state.weather.consolidatedWeather[0].minTemp,
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              );
            } else if (state is WeatherLoadingState) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else {
              if (state is WeatherErrorState) {
                return const Center(
                  child: Text("Hata oluştu"),
                );
              } else {
                return const Center(
                  child: Text("Şuan birşeyler yanlış gidiyor"),
                );
              }
            }
          })),
    );
  }
}
