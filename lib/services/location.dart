import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import '../screens/loading_screen.dart';

class Location {
  late double latitude = 0.0;
  late double longitude = 0.0;

  Future<void> checkLocationPermission() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // serviço de localização desabilitado. Não será possível continuar
      return Future.error('O serviço de localização está desabilitado.');
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Sem permissão para acessar a localização
        return Future.error('Sem permissão para acesso à localização');
      }
    }
    if (permission == LocationPermission.deniedForever) {
      // permissões negadas para sempre
      return Future.error('A permissão para acesso a localização foi negada para sempre. Não é possível pedir permissão.');
    }


  }

  Future<void> getCurrentLocation() async {
    await checkLocationPermission();

    Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.low);
    latitude = position.latitude;
    longitude = position.longitude;
  }

  @override
  Widget build(BuildContext context) {
    getCurrentLocation();
    return const Center(

    );
  }

  getCurrentPosition() {
    getCurrentLocation();
  }

}