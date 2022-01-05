import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:parking_finder/MVC%20Structure/Controller/book_spot.dart';

class ParkingCard extends StatefulWidget {
  const ParkingCard({Key? key}) : super(key: key);

  @override
  _ParkingCardState createState() => _ParkingCardState();
}

class _ParkingCardState extends State<ParkingCard> {
  final itemSize = 100.0;
  final _firestore = FirebaseFirestore.instance;
  final _auth = FirebaseAuth.instance;

  late User loggedInUser;

  DateTime now = DateTime.now();

  final List _spots = [];

  void initState() {
    getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.white,
        ),
        title: Text("Parking Spaces"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        physics: ClampingScrollPhysics(),
        scrollDirection: Axis.vertical,
        // shrinkWrap: true,
        child: Column(
          children: [
            ListView.builder(
                shrinkWrap: true,
                physics: ClampingScrollPhysics(),
                itemCount: _spots.length,
                itemBuilder: (_, index) {
                  final String bill = _spots[index]["bill"];
                  final String duration = _spots[index]["duration"];
                  final String address = _spots[index]["address"];
                  // final String userName = _post[index]["userName"];

                  return Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      margin: EdgeInsets.all(30),
                      elevation: 6.0,
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Color(0xFF577BC1),
                        ),
                        child: Column(
                          children: [
                            ListTile(
                              title: Text(
                                "\$$bill/$duration${"hr"}",
                                style: TextStyle(
                                    fontSize: 30,
                                    fontFamily: 'sans-serif',
                                    fontWeight: FontWeight.bold),
                              ),
                              subtitle: Text(
                                "Location : $address",
                                style: TextStyle(
                                    fontSize: 20,
                                    fontFamily: 'sans-serif',
                                    fontWeight: FontWeight.bold),
                              ),
                              trailing: Icon(Icons.bookmark_border_rounded),
                            ),
                            Container(
                                child: Column(children: [
                              Container(
                                padding: EdgeInsets.all(16.0),
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  address,
                                  style: TextStyle(
                                      fontFamily: 'sans-serif',
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.only(
                                      bottomRight: Radius.circular(20),
                                      bottomLeft: Radius.circular(20)),
                                  //border: Border.all(color: Colors.grey),
                                  color: Color(0xFF000957),
                                ),
                                child: ButtonBar(
                                  children: [
                                    TextButton(
                                      child: const Text(
                                        'Book!',
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 30,
                                            fontFamily: 'sans-serif',
                                            fontWeight: FontWeight.bold),
                                      ),
                                      onPressed: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (_) =>
                                                  BookSpot(_spots[index])),
                                        );
                                      },
                                    )
                                  ],
                                ),
                              ),
                            ])),
                          ],
                        ),
                      ));
                }),
          ],
        ),
      ),
    );
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
          "ownerName": qn.docs[i]["ownerName"],
          "productID": qn.docs[i].id
          // "userName": qn.docs[i]["userName"],
        });
      }
      print(_spots[1]['lat']);
      print(_spots[1]['long']);
    });
  }
}
