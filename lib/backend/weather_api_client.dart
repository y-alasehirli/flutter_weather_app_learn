import 'dart:convert';
import 'package:flutter33_hava_durumu_app/models/weather_model.dart';
import 'package:http/http.dart' as http;

class WeatherApiClient {
  static const String _searchUrl =
      "https://www.metaweather.com/api/location/search/?query=";
  static const String _getUrl = "https://www.metaweather.com/api/location/";

  Future<int> findWoeid(String sehir) async {
    Uri findWoeid = Uri.parse(_searchUrl + sehir);
    http.Response response = await http.get(findWoeid);
    if (response.statusCode != 200) {
      throw Exception("Woeid verisi elde edilemedi");
    }
    List jsondecoded = jsonDecode(response.body) as List;
    int woeid = jsondecoded[0]["woeid"];
    return woeid;
  }

  Future<Weather> getWeatherToModel(int woeid) async {
    Uri finalUri = Uri.parse(_getUrl + woeid.toString());
    http.Response response = await http.get(finalUri);
    if (response.statusCode != 200) {
      throw Exception("Şehir verisi elde edilemedi");
    }
    var finalJson = jsonDecode(response.body);
    Weather cityWeather = Weather.fromJson(finalJson);
    return cityWeather;
  }
}
