import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

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

  void initState() {
    super.initState();
    getData();
    //getCurrentUser();
  }

  @override
  Widget build(BuildContext context) {
    final String ownerName = widget._spot['ownerName'];
    final String address = widget._spot['address'];
    final String bill = widget._spot['bill'];
    return Scaffold(
      appBar: AppBar(
        title: Text('Book Your Spot'),
      ),
      body: Column(
        children: [
          Container(
            child: Text(
              'Owner Name : $ownerName',
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black),
            ),
          ),
          Container(
            child: Text(
              'Address : $address',
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black),
            ),
          ),
          Container(
            child: Text(
              'Bill / hr : $bill',
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black),
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
          });
        } else {
          print("Not found");
          //elseCall();
        }
      }
    });
  }
}
