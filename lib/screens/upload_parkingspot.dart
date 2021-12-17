import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/get_navigation/src/snackbar/snackbar.dart';
import 'package:parking_finder/screens/home_page.dart';

class CreateSpot extends StatefulWidget {
  static String id = 'create_item';
  const CreateSpot({Key? key}) : super(key: key);

  @override
  _CreateSpotState createState() => _CreateSpotState();
}

class _CreateSpotState extends State<CreateSpot> {
  int currentStep = 0;
  final _firestore = FirebaseFirestore.instance;
  final _auth = FirebaseAuth.instance;
  late User loggedInUser;

  late String address;
  late String bill;
  late String coordinates_lat;
  late String coordinates_lang;
  late String duration;
  bool isCompleted = false;

  void getCurrentUser() async {
    try {
      final user = _auth.currentUser!;
      loggedInUser = user;

      CollectionReference _collectionRef =
          FirebaseFirestore.instance.collection('parking-spots');
      _collectionRef.doc(user.email).collection('info').doc().set({
        'address': address,
        'bill': bill,
        'duration': duration,
        'userName': loggedInUser.displayName,
      });

      _firestore.collection('map_spots').add({
        'address': address,
        'latitude': coordinates_lat,
        'longitude': coordinates_lang,
        'bill': bill,
        'duration': duration,
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.indigo,
      appBar: AppBar(
        title: Text("Create A Parking Spot"),
        centerTitle: true,
      ),
      body: Stepper(
        type: StepperType.vertical,
        steps: getSteps(),
        currentStep: currentStep,
        onStepContinue: () {
          final isLastStep = currentStep == getSteps().length - 1;

          if (isLastStep) {
            setState(() {
              getCurrentUser();
            });

            Navigator.push(
                context, MaterialPageRoute(builder: (context) => HomePage()));
            print('Completed');

            // You can connect here with FireBase
            Get.snackbar(
              "Item Posted",
              "You Have Successfully Added an Item for Auction",
              snackPosition: SnackPosition.TOP,
            );
          } else {
            setState(() => currentStep += 1);
          }
        },
        onStepCancel: () => setState(() => currentStep -= 1),
        controlsBuilder: (context, {onStepContinue, onStepCancel}) {
          return Container(
            margin: EdgeInsets.only(top: 50),
            child: Row(children: [
              Expanded(
                child: ElevatedButton(
                  child: Text('Continue'),
                  onPressed: onStepContinue,
                ),
              ),
              const SizedBox(width: 12),
              if (currentStep != 0)
                Expanded(
                  child: ElevatedButton(
                    child: Text('Back'),
                    onPressed: onStepCancel,
                  ),
                ),
            ]),
          );
        },
      ),
    );
  }

  List<Step> getSteps() => [
        Step(
          state: currentStep > 0 ? StepState.complete : StepState.indexed,
          isActive: currentStep >= 0,
          title: Text("Parking Address", style: TextStyle(color: Colors.white)),
          content: Column(
            children: <Widget>[
              TextFormField(
                onChanged: (value) {
                  address = value;
                },
                decoration: InputDecoration(labelText: 'address'),
              ),
              TextFormField(
                onChanged: (value) {
                  coordinates_lat = value;
                },
                decoration: InputDecoration(labelText: 'Latitude'),
              ),
              TextFormField(
                onChanged: (value) {
                  coordinates_lang = value;
                },
                decoration: InputDecoration(labelText: 'Longitude'),
              ),
            ],
          ),
        ),
        Step(
          state: currentStep > 2 ? StepState.complete : StepState.indexed,
          isActive: currentStep >= 2,
          title: Text("Billing Information",
              style: TextStyle(color: Colors.white)),
          content: Column(
            children: <Widget>[
              TextFormField(
                onChanged: (value) {
                  bill = value;
                },
                decoration: InputDecoration(labelText: 'bill per hour'),
              ),
              TextFormField(
                onChanged: (value) {
                  duration = value;
                },
                decoration: InputDecoration(labelText: 'Parking Duration'),
              )
            ],
          ),
        ),
      ];
}
