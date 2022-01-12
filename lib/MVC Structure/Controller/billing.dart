import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class Billing extends StatefulWidget {
  var _bill;
  Billing(this._bill);

  @override
  _BillingState createState() => _BillingState();
}

class _BillingState extends State<Billing> {
  final _firestore = FirebaseFirestore.instance;

  final _auth = FirebaseAuth.instance;
  late User loggedInUser;
  List _spotDetails = [];

  void initState() {
    super.initState();

    getData();
    //getCurrentUser();
  }

  @override
  Widget build(BuildContext context) {
    final String ownerName = widget._bill['ownerName'];
    final String address = widget._bill['address'];
    final String bill = widget._bill['bill'];
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
                onPressed: () {},
              ),
            ),
          ),
        ],
      ),
    );
  }

  getData() async {
    final driverName = widget._bill['driverName'];
    QuerySnapshot qn = await _firestore.collection('bill').get();
    setState(() {
      for (int i = 0; i < qn.docs.length; i++) {
        if (driverName == qn.docs[i]["driverName"]) {
          _spotDetails.add({
            "ownerName": qn.docs[i]["ownerName"],
            "bill": qn.docs[i]["bill"],
            "address": qn.docs[i]["address"],
          });
        } else {
          print("Not found");
          //elseCall();
        }
      }
    });
  }
}
