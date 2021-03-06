import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:parking_finder/MVC%20Structure/Controller/billing.dart';
import 'package:parking_finder/MVC%20Structure/Model/user_options.dart';
import 'package:parking_finder/MVC%20Structure/View/home_page.dart';

// ignore: must_be_immutable
class BookSpot extends StatefulWidget {
  var _spot;
  BookSpot(this._spot);

  @override
  _BookSpotState createState() => _BookSpotState();
}

class _BookSpotState extends State<BookSpot> {
  final _firestore = FirebaseFirestore.instance;

  final _auth = FirebaseAuth.instance;
  late User loggedInUser;
  List _spotDetails = [];

  late String billAddress;
  late String billAmount;
  late String billOwnerName;
  late String billDriverName;
  late String billPostId;
  void initState() {
    super.initState();

    getData();
    getCurrentUser();
  }

  void getCurrentUser() async {
    try {
      final user = _auth.currentUser!;
      loggedInUser = user;

      //final userName = loggedInUser.displayName!;
      // userEmail = loggedInUser.email!;

    } catch (e) {
      print(e);
    }
  }

  void setData() async {
    try {
      _firestore.collection('bill').add({
        'address': billAddress,
        'bill': billAmount,
        'driverName': loggedInUser.displayName,
        'ownerName': billOwnerName,
        'paid': "No",
        'postId': billPostId
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    final String ownerName = widget._spot['ownerName'];
    final String address = widget._spot['address'];
    final String bill = widget._spot['bill'];

    billOwnerName = widget._spot['ownerName'];
    billAddress = widget._spot['address'];
    billAmount = widget._spot['bill'];

    billPostId = widget._spot['productID'];

    return Scaffold(
      appBar: AppBar(
        title: Text('Book Your Spot'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                    child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Owner Name',
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.black),
                    ),
                    SizedBox(height: 10),
                    Text(
                      '$ownerName',
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey),
                    ),
                  ],
                )),
                SizedBox(height: 30),
                Container(
                    child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Address',
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.black),
                    ),
                    SizedBox(height: 10),
                    Text(
                      '$address',
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey),
                    ),
                  ],
                )),
                SizedBox(height: 30),
                Container(
                    child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Bill / hr',
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.black),
                    ),
                    SizedBox(height: 10),
                    Text(
                      '$bill',
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey),
                    ),
                  ],
                )),
              ],
            ),
          ),
          Center(
            child: Container(
              margin: EdgeInsets.all(25),
              child: FlatButton(
                child: Text(
                  'Confirm',
                  style: TextStyle(fontSize: 20.0),
                ),
                color: Colors.blueAccent,
                textColor: Colors.white,
                onPressed: () {
                  setData();
                  Navigator.push(
                      context, MaterialPageRoute(builder: (_) => HomePage()));
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  getData() async {
    final postId = widget._spot['productID'];
    QuerySnapshot qn = await _firestore.collection('map_spots').get();
    setState(() {
      for (int i = 0; i < qn.docs.length; i++) {
        if (postId == qn.docs[i]["postId"]) {
          _spotDetails.add({
            "ownerName": qn.docs[i]["ownerName"],
            "bill": qn.docs[i]["bill"],
            "address": qn.docs[i]["address"],
            "postId": postId
          });
        } else {
          print("Not found");
          //elseCall();
        }
      }
    });
  }
}
