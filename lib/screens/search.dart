import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class SearchParking extends StatefulWidget {
  const SearchParking({Key? key}) : super(key: key);

  @override
  _SearchParkingState createState() => _SearchParkingState();
}

class _SearchParkingState extends State<SearchParking> {
  late GoogleMapController mapController;

  Set<Marker> _markers = {};

  build(context) {
    return Stack(
      children: [
        GoogleMap(
          initialCameraPosition:
              CameraPosition(target: LatLng(23.7409387, 90.3751147), zoom: 16),
          onMapCreated: _onMapCreated,
          markers: _markers,
          mapType: MapType.normal,
          myLocationEnabled: true,
        ),
      ],
    );
  }

  _onMapCreated(GoogleMapController controller) {
    setState(() {
      mapController = controller;
      _markers.add(Marker(
          markerId: MarkerId('id-1'),
          position: LatLng(23.7409387, 90.3751147),
          infoWindow: InfoWindow(
            title: 'Parking Slot-1',
            snippet: 'Rate : 250/hr',
          )));
    });
  }
}
