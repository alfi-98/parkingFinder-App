import 'package:flutter/material.dart';
import 'package:parking_finder/screens/search.dart';
import 'package:parking_finder/services/geolocator_service.dart';
import 'package:provider/provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  final locatorService = GeoLocatorService();

  @override
  Widget build(BuildContext context) {
    return FutureProvider(
      create: (context) => locatorService.getLocation(),
      initialData: null,
      child: MaterialApp(
        title: 'Parking Finder App',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: Search(),
      ),
    );
  }
}
