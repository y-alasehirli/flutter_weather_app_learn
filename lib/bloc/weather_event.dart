part of 'weather_bloc.dart';

abstract class WeatherEvent extends Equatable {
  const WeatherEvent();

  @override
  List<Object> get props => [];
}

class GetWeatherEvent extends WeatherEvent {
  final String sehir;
  const GetWeatherEvent({required this.sehir});
  @override
  List<Object> get props => [sehir];
}

class RefreshWeatherEvent extends WeatherEvent {
  final String sehir;
  const RefreshWeatherEvent({required this.sehir});
  @override
  List<Object> get props => [sehir];
}
