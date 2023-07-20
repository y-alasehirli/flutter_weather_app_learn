import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter33_hava_durumu_app/backend/weather_repository.dart';
import 'package:flutter33_hava_durumu_app/const/interval_tools.dart';
import 'package:flutter33_hava_durumu_app/models/weather_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'weather_event.dart';
part 'weather_state.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  WeatherBloc() : super(WeatherInitial()) {
    on<GetWeatherEvent>(_getWeatherEvent);
    on<RefreshWeatherEvent>(_refreshWeatherEvent);
  }
  final WeatherRepository _weatherRepository = locator.get<WeatherRepository>();

  void _getWeatherEvent(
      GetWeatherEvent event, Emitter<WeatherState> emit) async {
    emit(WeatherLoadingState());
    try {
      Weather weather = await _weatherRepository.getWeather(event.sehir);
      emit(WeatherLoadedState(weather: weather));
    } on Exception catch (_) {
      emit(WeatherErrorState());
    }
  }

  _refreshWeatherEvent(
      RefreshWeatherEvent event, Emitter<WeatherState> emit) async {
    try {
      Weather weather = await _weatherRepository.getWeather(event.sehir);
      emit(WeatherLoadedState(weather: weather));
    } on Exception catch (_) {
      emit;
    }
  }
}
