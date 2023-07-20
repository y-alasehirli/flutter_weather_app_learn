import 'package:flutter33_hava_durumu_app/backend/weather_repository.dart';
import 'package:flutter33_hava_durumu_app/const/interval_tools.dart';
import 'package:flutter33_hava_durumu_app/models/weather_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

enum WeatherPState { initial, idle, loading, loaded, error }

class WeatherListModel {
  final Weather _weather;
  final WeatherPState _weatherPState;
  const WeatherListModel(this._weather, this._weatherPState);
}

class WeatherNotifier extends StateNotifier<WeatherPState> {
  WeatherNotifier() : super(WeatherPState.initial);

  Weather? _weather;
  WeatherPState _pState = WeatherPState.initial;
  Weather? get weather => _weather;
  WeatherPState get pState => _pState;
  set pState(WeatherPState value) {
    value = state;
    _pState = value;
    print(" pstate: $_pState");
  }

  Future<Weather?> getWeather(String sehir) async {
    WeatherRepository weatherRepository = locator.get<WeatherRepository>();
    try {
      state = WeatherPState.loading;
      pState = state;
      Weather result = await weatherRepository.getWeather(sehir);
      _weather = result;
      print("şehir getirildi");
      state = WeatherPState.loaded;
      pState = state;
      print("$state");
      return _weather;
    } on Exception catch (_) {
      state = WeatherPState.error;
      pState = state;
      return null;
    }
  }

  Future<Weather?> refreshWeather(String sehir) async {
    WeatherRepository weatherRepository = locator.get<WeatherRepository>();
    try {
      state = WeatherPState.idle;
      Weather result = await weatherRepository.getWeather(sehir);
      _weather = result;
      print("şehir getirildi");
      state = WeatherPState.loaded;
      pState = state;
      print("$state");
      return _weather;
    } on Exception catch (_) {
      state = WeatherPState.error;
      pState = state;
      return null;
    }
  }
}
