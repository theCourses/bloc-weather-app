import 'package:flutter/material.dart';
import 'package:weather_app/repositories/weather_repository.dart';
import 'package:weather_app/services/weather_api_services.dart';
import 'package:http/http.dart' as http;

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  _fetchWeather() {
    WeatherRepository(
            weatherApiServices: WeatherApiServices(httpClient: http.Client()))
        .fetchWeather('london');
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(title: const Text('Weather')),
      body: Center(
          child: ElevatedButton(
              onPressed: () async {
                _fetchWeather();
              },
              child: Text('Home'))),
    ));
  }
}
