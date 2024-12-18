import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  Position? _currentPosition;
  String? _weatherDescription;
  double? _temperature;
  final String _apiKey = '9a57547e9363f2d8e82d14ce0d5bb0c7'; // Remplace par ta clé API OpenWeatherMap
  late GoogleMapController _mapController;

  // Obtenir la position actuelle
  Future<void> _getCurrentLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Vérifie si les services de localisation sont activés
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Les services de localisation sont désactivés.');
    }

    // Vérifie les permissions
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Permission de localisation refusée.');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Les permissions de localisation sont refusées définitivement.');
    }

    // Obtenir la position actuelle
    Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );
    setState(() {
      _currentPosition = position;
    });

    // Charger la météo pour la position actuelle
    await _getWeather(position.latitude, position.longitude);
  }

  // Charger la météo
  Future<void> _getWeather(double latitude, double longitude) async {
    final url =
        'https://api.openweathermap.org/data/2.5/weather?lat=$latitude&lon=$longitude&units=metric&appid=$_apiKey&lang=fr';
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      setState(() {
        _weatherDescription = data['weather'][0]['description'];
        _temperature = data['main']['temp'];
      });
    } else {
      throw Exception('Erreur lors du chargement de la météo.');
    }
  }

  // Initialisation de la carte Google Maps
  void _onMapCreated(GoogleMapController controller) {
    _mapController = controller;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Mon Profil'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Affichage de la carte
            Container(
              height: 300,
              child: _currentPosition == null
                  ? Center(child: Text('Aucune position disponible.'))
                  : GoogleMap(
                      onMapCreated: _onMapCreated,
                      initialCameraPosition: CameraPosition(
                        target: LatLng(
                          _currentPosition!.latitude,
                          _currentPosition!.longitude,
                        ),
                        zoom: 14.0,
                      ),
                      markers: {
                        Marker(
                          markerId: MarkerId('currentLocation'),
                          position: LatLng(
                            _currentPosition!.latitude,
                            _currentPosition!.longitude,
                          ),
                        ),
                      },
                    ),
            ),

            SizedBox(height: 20),

            // Affichage de la météo
            if (_weatherDescription != null && _temperature != null)
              Column(
                children: [
                  Text(
                    'Météo actuelle : $_weatherDescription',
                    style: TextStyle(fontSize: 18),
                  ),
                  Text(
                    'Température : $_temperature°C',
                    style: TextStyle(fontSize: 18),
                  ),
                ],
              )
            else
              Center(child: Text('Chargement de la météo...')),

            SizedBox(height: 20),

            // Bouton pour obtenir la localisation et la météo
            ElevatedButton(
              onPressed: _getCurrentLocation,
              child: Text('Obtenir ma position et la météo'),
            ),
          ],
        ),
      ),
    );
  }
}
