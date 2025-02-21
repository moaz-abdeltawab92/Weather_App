import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:weather_app/models/weather_model.dart';
// "as http" --> means to can easily access all methods in the package of http

class WeatherServices {
  String baseUrl = "http://api.weatherapi.com/v1";
  String apiKey = "3125b17677ca428a85d101900250902";
  Future<WeatherModel> getWeather({required String cityName}) async {
    Uri url =
        Uri.parse("$baseUrl/forecast.json?key=$apiKey&q=$cityName&days=7");
    http.Response response = await http.get(url);
    //always make the value of Map --> dynamic
    Map<String, dynamic> data = jsonDecode(response.body);
    // Todo: try to use the icon from api

    WeatherModel weather = WeatherModel.fromJson(data);

    return weather;
  }
}
