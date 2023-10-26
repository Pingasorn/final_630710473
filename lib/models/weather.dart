import 'package:final_630710473/models/condition.dart';

import '../main.dart';

class WeatherData {
  final String city;
  final String country;
  final String lastUpdated;
  final double tempC;
  final double tempF;
  final double feelsLikeC;
  final double feelsLikeF;
  final double windKph;
  final double windMph;
  final int humidity;
  final int uv;
  final Condition condition;

  WeatherData({
    required this.city,
    required this.country,
    required this.lastUpdated,
    required this.tempC,
    required this.tempF,
    required this.feelsLikeC,
    required this.feelsLikeF,
    required this.windKph,
    required this.windMph,
    required this.humidity,
    required this.uv,
    required this.condition,
  });

  factory WeatherData.fromJson(Map<String, dynamic> json) {
    return WeatherData(
      city: json['city'],
      country: json['country'],
      lastUpdated: json['lastUpdated'],
      tempC: json['tempC'].toDouble(),
      tempF: json['tempF'].toDouble(),
      feelsLikeC: json['feelsLikeC'].toDouble(),
      feelsLikeF: json['feelsLikeF'].toDouble(),
      windKph: json['windKph'].toDouble(),
      windMph: json['windMph'].toDouble(),
      humidity: json['humidity'],
      uv: json['uv'],
      condition: Condition.fromJson(json['condition']),
    );
  }
}
