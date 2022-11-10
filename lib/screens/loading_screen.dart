import 'package:flutter/material.dart';
import '../services/location.dart';
import 'dart:convert';
import '../screens/location_screen.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../services/weather.dart';

const apiKey = '55441606db9714453cc79d199f1dd74b';

class LoadingScreen extends StatefulWidget {
  const LoadingScreen({Key? key}) : super(key: key);

  @override
  State<LoadingScreen> createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  late double latitude;
  late double longitude;

  void pushToLocationScreen(dynamic weatherData) {
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return LocationScreen(localWeatherData: weatherData);
    }));
  }

  Future<void> getLocation() async {
    var location = Location();
    await location.getCurrentPosition();

    latitude = location.latitude!;
    longitude = location.longitude!;

    getData();
  }

  void getData() async {
    var weatherData = await WeatherModel().getLocationWeather();
    pushToLocationScreen(weatherData);
  }

  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    getData();
    return const Center(
      child: SpinKitDoubleBounce(
        color: Colors.white,
        size: 100.0,
      ),
    );
  }
}