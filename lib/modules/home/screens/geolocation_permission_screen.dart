import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

class GeolocationPermissionScreen extends StatefulWidget {
  @override
  _GeolocationPermissionScreenState createState() =>
      _GeolocationPermissionScreenState();
}

class _GeolocationPermissionScreenState
    extends State<GeolocationPermissionScreen> {
  bool _locationServiceEnabled = false;
  LocationPermission _locationPermission = LocationPermission.denied;

  @override
  void initState() {
    super.initState();
    _checkLocationServices();
  }

  Future<void> _checkLocationServices() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await Geolocator.openLocationSettings();
      if (!serviceEnabled) {
        return;
      }
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {}
    }

    if (permission == LocationPermission.deniedForever) {}

    setState(() {
      _locationPermission = permission;
      _locationServiceEnabled = serviceEnabled;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Permissão de Geolocalização'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: _checkLocationServices,
          child: Text('Solicitar Permissão de Localização'),
        ),
      ),
    );
  }
}
