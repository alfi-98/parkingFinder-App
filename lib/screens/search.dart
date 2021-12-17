import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
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
  final List _spots = [];
  final _firestore = FirebaseFirestore.instance;
  final _auth = FirebaseAuth.instance;

  late User loggedInUser;

  @override
  void initState() {
    super.initState();
    getData();
  }

  build(context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.white,
        ),
        title: Text("map"),
        centerTitle: true,
      ),
      body: GoogleMap(
        initialCameraPosition:
            CameraPosition(target: LatLng(23.7409387, 90.3751147), zoom: 16),
        onMapCreated: _onMapCreated,
        markers: _markers,
        mapType: MapType.normal,
        myLocationEnabled: true,
      ),
    );
  }

  _onMapCreated(GoogleMapController controller) {
    setState(() {
      for (var i = 0; i < _spots.length; i++) {
        mapController = controller;
        _markers.add(Marker(
            markerId: MarkerId(_spots[i]['productID']),
            position: LatLng(_spots[i]['lat'], _spots[i]['long']),
            infoWindow: InfoWindow(
              title: _spots[i]['address'],
              snippet: "${_spots[i]['bill']} ${'/'} ${_spots[i]['duration']}  ",
            )));
      }
    });
  }

  getData() async {
    QuerySnapshot qn = await _firestore.collection('map_spots').get();
    setState(() {
      for (int i = 0; i < qn.docs.length; i++) {
        _spots.add({
          "address": qn.docs[i]["address"],
          "bill": qn.docs[i]["bill"],
          "duration": qn.docs[i]["duration"],
          "lat": qn.docs[i]["latitude"],
          "long": qn.docs[i]["longitude"],
          "productID": qn.docs[i].id
          // "userName": qn.docs[i]["userName"],
        });
      }
      print(_spots[1]['lat']);
      print(_spots[1]['long']);
    });
  }
}
