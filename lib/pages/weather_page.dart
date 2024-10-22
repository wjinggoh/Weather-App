import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:tutorialflutter/models/weather_model.dart';
import 'package:tutorialflutter/services/weather_service.dart';

class WeatherPage extends StatefulWidget {
  const WeatherPage({super.key});

  @override
  State<WeatherPage> createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {
  // API key
  final _weatherService = WeatherService('5b3447d96f726b4752bed5e6f3cf04f4');
  Weather? _weather;

  // Fetch weather
  _fetchWeather() async {
    // Get the current city
    String cityName = await _weatherService.getCurrentCity();

    // Get weather for city
    try {
      final weather = await _weatherService.getWeather(cityName);
      setState(() {
        _weather = weather;
      });
    } catch (e) {
      print(e);
    }
  }

  // Initialize state
  @override
  void initState() {
    super.initState();

    // Fetch weather on startup
    _fetchWeather();
  }

  // Method to get Lottie animation based on weather condition
  Widget _getWeatherAnimation() {
    switch (_weather?.mainCondition) {
      case 'Clouds':
        return Lottie.asset('assets/cloudy.json');
      case 'Rain':
        return Lottie.asset('assets/rain.json');
      case 'Clear':
        return Lottie.asset('assets/sunny.json');
      case 'Thunderstorm':
        return Lottie.asset('assets/thunderstorm.json');
      default:
        return Lottie.asset(
            'assets/sunnyrain.json'); // Default animation for unknown weather conditions
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // City name
            Text(
              _weather?.cityName ?? "Loading city...",
              style: const TextStyle(
                fontFamily: 'PlaywriteGBS',
                fontSize: 24,
                fontStyle: FontStyle.italic,
              ),
            ),

            // Animation based on weather condition
            _weather != null
                ? _getWeatherAnimation() // Show the appropriate animation
                : Lottie.asset('assets/loading.json'), // Loading animation

            // Temperature
            Text(
              '${_weather?.temperature.round()} C',
              style: const TextStyle(
                fontFamily: 'PlaywriteGBS',
                fontSize: 24,
                fontStyle: FontStyle.italic,
              ),
            ),

            // Weather condition
            Text(
              _weather?.mainCondition ?? "",
              style: const TextStyle(
                fontFamily: 'PlaywriteGBS',
                fontSize: 24,
                fontStyle: FontStyle.italic,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
