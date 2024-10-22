import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:tutorialflutter/models/weather_model.dart';
import 'package:tutorialflutter/services/weather_service.dart';


class WeatherPage extends StatefulWidget{
  const WeatherPage({super.key});

  @override
  State<WeatherPage> createState() =>_WeatherPageState();

}

class _WeatherPageState extends State<WeatherPage>{

  //api key
  final _weatherService =WeatherService('YOUR API KEY');
  Weather? _weather;

  //fetch weather
  _fetchWeather() async{
    //get the current city
    String cityName= await _weatherService.getCurrentCity();

    //get weather for city
    try{
      final weather= await _weatherService.getWeather(cityName);
      setState((){
        _weather =weather;
      });
    }

    //any errors
    catch(e){
      print(e);
    }

  }

  //weather animations

  //init state
  @override
  void initState(){
    super.initState();

    //fetch weather on startup
    _fetchWeather();
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
      body:Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
        children: [
          //city name
          Text(_weather?.cityName ?? "loading city..."),

          //animation
          Lottie.asset('assets/sunnyrain.json'),
          //temperature
          Text('${_weather?.temperature.round()} C'),

          //weather condition
          Text(_weather?.mainCondition ?? "")
        ],
      )
    )
    );
  }
}