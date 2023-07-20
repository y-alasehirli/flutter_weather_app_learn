import 'package:flutter33_hava_durumu_app/const/interval_tools.dart';
import 'package:flutter33_hava_durumu_app/models/weather_model.dart';
import 'weather_api_client.dart';

class WeatherRepository {
  final WeatherApiClient _apiClient = locator.get<WeatherApiClient>();

  Future<Weather> getWeather(String sehir) async {
    int woeid = await _apiClient.findWoeid(sehir);
    Weather weather = await _apiClient.getWeatherToModel(woeid);
    return weather;
  }
}
