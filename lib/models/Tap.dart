import 'dart:convert';

import 'package:final_630710473/models/weather.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class WeatherTab extends StatefulWidget {
  final String city;

  const WeatherTab({
    Key? key,
    required this.city,
  }) : super(key: key);

  @override
  _WeatherTabState createState() => _WeatherTabState();
}

class _WeatherTabState extends State<WeatherTab> {
  Future<WeatherData?> fetchWeatherData() async {
    final response = await http.get(Uri.parse(
        'https://cpsu-test-api.herokuapp.com/api/1_2566/weather/current?city=${widget.city}'));

    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      return WeatherData.fromJson(jsonData);
    } else {
      throw Exception('Failed to load weather data');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color.fromARGB(
          255, 210, 231, 248), // Change this to the desired background color
      child: FutureBuilder<WeatherData?>(
        future: fetchWeatherData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData) {
            return Center(child: Text('No data available'));
          } else {
            final weatherData = snapshot.data!;
            return Column(
              children: [
                Container(
                  padding: EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment:
                        CrossAxisAlignment.center, // Center text horizontally
                    children: [
                      Text(
                        '${weatherData.city}',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 60.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        '${weatherData.lastUpdated}',
                        style: TextStyle(
                          color: Colors.black,
                        ),
                      ),
                      Image.network(weatherData.condition.icon),
                      Text(
                        '${weatherData.condition.text}',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 18.0,
                        ),
                      ),
                      Text(
                        '${weatherData.tempC.toStringAsFixed(1)}°C',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 48.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        'Feel like ${weatherData.feelsLikeC.toStringAsFixed(1)}°C',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Wind'),
                          Text(
                              '${weatherData.windKph.toStringAsFixed(1)} km/h'),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Humidity'),
                          Text('${weatherData.humidity}%'),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('UV Index'),
                          Text('${weatherData.uv}'),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            );
          }
        },
      ),
    );
  }
}
