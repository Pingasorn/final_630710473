import 'dart:convert';
import 'package:final_630710473/models/weather.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class WeatherApp extends StatefulWidget {
  @override
  _WeatherAppState createState() => _WeatherAppState();
}

class _WeatherAppState extends State<WeatherApp> {
  Future<WeatherData?> fetchWeatherData() async {
    final response = await http.get(Uri.parse(
        'https://cpsu-test-api.herokuapp.com/api/1_2566/weather/current?city=Nakhon Pathom'));

    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      return WeatherData.fromJson(jsonData);
    } else {
      throw Exception('Failed to load weather data');
    }
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    throw UnimplementedError();
  }
}
