import 'package:flutter33_hava_durumu_app/backend/weather_api_client.dart';
import 'package:flutter33_hava_durumu_app/backend/weather_repository.dart';
import 'package:flutter33_hava_durumu_app/bloc/weather_bloc.dart';
import 'package:flutter33_hava_durumu_app/pods/weather_model_pod.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_it/get_it.dart';

final GetIt locator = GetIt.instance;
void setupLocator() {
  locator.registerLazySingleton<WeatherApiClient>(() => WeatherApiClient());
  locator.registerLazySingleton<WeatherRepository>(() => WeatherRepository());
  locator.registerLazySingleton<WeatherBloc>(() => WeatherBloc());
}

final weatherProvider =
    StateNotifierProvider.autoDispose<WeatherNotifier, WeatherPState>((ref) {
  return WeatherNotifier();
});
