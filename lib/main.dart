// import 'package:flutter/material.dart';
// import 'package:geolocator/geolocator.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:parking_finder/screens/search.dart';
// import 'package:parking_finder/services/geolocator_service.dart';
// import 'package:provider/provider.dart';

// void main() => runApp(MyApp());

// class MyApp extends StatelessWidget {
//   const MyApp({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       home: const MyHomePage(),
//     );
//   }
// }

// class MyHomePage extends StatefulWidget {
//   const MyHomePage({Key? key}) : super(key: key);

//   @override
//   _MyHomePageState createState() => _MyHomePageState();
// }

// class _MyHomePageState extends State<MyHomePage> {
//   bool mapToggle = false;

//   // ignore: prefer_typing_uninitialized_variables
//   var currentLocation;
//   late GoogleMapController mapController;

//   @override
//   void initState() {
//     super.initState();

//     Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high)
//         .then((currloc) {
//       setState(() {
//         currentLocation = currloc;
//         mapToggle = true;
//         print(currentLocation.latitude);
//         print(currentLocation.longitude);
//       });
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         appBar: AppBar(
//           title: Text('Car Parking Finder'),
//         ),
//         body: SingleChildScrollView(
//           child: Column(
//             children: <Widget>[
//               Stack(
//                 children: <Widget>[
//                   Container(
//                     height: MediaQuery.of(context).size.height - 80.0,
//                     width: double.infinity,
//                     child: mapToggle
//                         ? GoogleMap(
//                             // myLocationEnabled: true,
//                             onMapCreated: onMapCreated,

//                             initialCameraPosition: CameraPosition(
//                                 target: LatLng(23.7411389, 90.375819),
//                                 zoom: 18.0),
//                             zoomGesturesEnabled: true,
//                           )
//                         : Center(
//                             child: CircularProgressIndicator(),
//                           ),
//                   )
//                 ],
//               )
//             ],
//           ),
//         ));
//   }

//   void onMapCreated(controller) {
//     setState(() {
//       mapController = controller;
//     });
//   }
// }

// class MyApp extends StatelessWidget {
//   final locatorService = GeoLocatorService();

//   @override
//   Widget build(BuildContext context) {
//     return FutureProvider(
//       create: (context) => locatorService.getLocation(),
//       initialData: null,
//       child: MaterialApp(
//         title: 'Parking Finder App',
//         theme: ThemeData(
//           primarySwatch: Colors.blue,
//         ),
//         home: Search(),
//       ),
//     );
//   }
// }

// import 'package:flutter/material.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:location/location.dart';

// void main() {
//   runApp(MyApp());
// }

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       home: MyHomePage(),
//     );
//   }
// }

// class MyHomePage extends StatefulWidget {
//   @override
//   _MyHomePageState createState() => _MyHomePageState();
// }

// class _MyHomePageState extends State<MyHomePage> {
//   final LatLng _initialcameraposition = const LatLng(23.7409387, 90.3751147);
//   late GoogleMapController _controller;
//   final Location _location = Location();

//   void _onMapCreated(GoogleMapController _cntlr) {
//     _controller = _cntlr;
//     _location.onLocationChanged.listen((l) {
//       _controller.animateCamera(
//         CameraUpdate.newCameraPosition(
//           CameraPosition(target: LatLng(l.latitude!, l.longitude!), zoom: 15),
//         ),
//       );
//       print(l.latitude);
//       print(l.longitude);
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Container(
//         height: MediaQuery.of(context).size.height,
//         width: MediaQuery.of(context).size.width,
//         child: Stack(
//           children: [
//             GoogleMap(
//               initialCameraPosition:
//                   CameraPosition(target: _initialcameraposition),
//               mapType: MapType.normal,
//               myLocationEnabled: true,
//               onMapCreated: _onMapCreated,

//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:parking_finder/screens/home_page.dart';
import 'package:parking_finder/screens/search.dart';
import 'package:parking_finder/screens/welcome_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
    MyApp(),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Car Parking Finder',
      theme: ThemeData(
        primarySwatch: Colors.indigo,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: WelcomeScreen(),
    );
  }
}

// class FireMap extends StatefulWidget {
//   const FireMap({Key? key}) : super(key: key);

//   @override
//   _FireMapState createState() => _FireMapState();
// }

// class _FireMapState extends State<FireMap> {
//   late GoogleMapController mapController;

//   Set<Marker> _markers = {};

//   build(context) {
//     return Stack(
//       children: [
//         GoogleMap(
//           initialCameraPosition:
//               CameraPosition(target: LatLng(23.7409387, 90.3751147), zoom: 16),
//           onMapCreated: _onMapCreated,
//           markers: _markers,
//           mapType: MapType.normal,
//           myLocationEnabled: true,
//         ),
//         // Positioned(
//         //   bottom: 50,
//         //   right: 10,

//         //   child:
//         //   FlatButton(

//         //     child: Icon(Icons.pin_drop, color: Colors.white,),
//         //     color: Colors.green,
//         //     //onPressed: _addMarker,
//         //     )
//         // )
//       ],
//     );
//   }

//   _onMapCreated(GoogleMapController controller) {
//     setState(() {
//       mapController = controller;
//       _markers.add(Marker(
//           markerId: MarkerId('id-1'),
//           position: LatLng(23.7409387, 90.3751147),
//           infoWindow: InfoWindow(
//             title: 'Parking Slot-1',
//             snippet: 'Rate : 250/hr',
//           )));
//     });
//   }
// }
