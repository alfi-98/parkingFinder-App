import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/get_navigation/src/snackbar/snackbar.dart';
import 'package:intl/intl.dart';
import 'package:parking_finder/MVC%20Structure/Controller/book_spot.dart';
import 'package:parking_finder/MVC%20Structure/View/home_page.dart';

class ParkingBills extends StatefulWidget {
  const ParkingBills({Key? key}) : super(key: key);

  @override
  _ParkingBillsState createState() => _ParkingBillsState();
}

class _ParkingBillsState extends State<ParkingBills> {
  final itemSize = 100.0;
  final _firestore = FirebaseFirestore.instance;
  final _auth = FirebaseAuth.instance;

  late User loggedInUser;

  DateTime now = DateTime.now();

  final List _bills = [];

  void initState() {
    getCurrentUser();
    getData();
    super.initState();
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

  void setPay(String pId) async {
    final postId = pId;
    try {
      QuerySnapshot qn = await _firestore.collection('bill').get();
      setState(() {
        for (int i = 0; i < qn.docs.length; i++) {
          if (postId == qn.docs[i]["postId"]) {
            String p = qn.docs[i].id;
            _firestore.collection('bill').doc(p).update({'paid': "Yes"});
          } else {
            print("Not found");
            //elseCall();
          }
        }
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.white,
        ),
        title: Text("Parking Bills"),
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
                itemCount: _bills.length,
                itemBuilder: (_, index) {
                  final String bill = _bills[index]["bill"];
                  final String ownerName = _bills[index]["ownerName"];
                  final String address = _bills[index]["address"];
                  final String paid = _bills[index]["paid"];
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
                                "\$$bill",
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
                                  "OwnerName : $ownerName",
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
                                child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      if (paid == "Yes") ...[
                                        Padding(
                                          padding: const EdgeInsets.all(10.0),
                                          child: Container(
                                            width: 60,
                                            height: 30,
                                            child: Center(
                                                child: Text(
                                              'Paid',
                                              style: TextStyle(
                                                  color: Colors.white),
                                            )),
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.only(
                                                  topLeft: Radius.circular(10),
                                                  topRight: Radius.circular(10),
                                                  bottomRight:
                                                      Radius.circular(10),
                                                  bottomLeft:
                                                      Radius.circular(10)),
                                              //border: Border.all(color: Colors.grey),

                                              color: Colors.green,
                                            ),
                                          ),
                                        ),
                                      ] else ...[
                                        Padding(
                                          padding: const EdgeInsets.all(10.0),
                                          child: Container(
                                            width: 60,
                                            height: 30,
                                            child: Center(
                                                child: Text(
                                              'Not Paid',
                                              style: TextStyle(
                                                  color: Colors.white),
                                            )),
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.only(
                                                  topLeft: Radius.circular(10),
                                                  topRight: Radius.circular(10),
                                                  bottomRight:
                                                      Radius.circular(10),
                                                  bottomLeft:
                                                      Radius.circular(10)),
                                              //border: Border.all(color: Colors.grey),

                                              color: Colors.red,
                                            ),
                                          ),
                                        ),
                                      ],
                                      ButtonBar(
                                        children: [
                                          TextButton(
                                            child: const Text(
                                              'Pay!',
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 30,
                                                  fontFamily: 'sans-serif',
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            onPressed: () {
                                              setPay(_bills[index]["postId"]);
                                              Get.snackbar(
                                                "Paid!",
                                                "Your Bill is Paid. Thank You",
                                                snackPosition:
                                                    SnackPosition.TOP,
                                              );
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (_) =>
                                                          HomePage()));
                                            },
                                          )
                                        ],
                                      ),
                                    ]),
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
    QuerySnapshot qn = await _firestore.collection('bill').get();
    setState(() {
      for (int i = 0; i < qn.docs.length; i++) {
        if (loggedInUser.displayName == qn.docs[i]["driverName"]) {
          _bills.add({
            "address": qn.docs[i]["address"],
            "bill": qn.docs[i]["bill"],
            "ownerName": qn.docs[i]["ownerName"],
            "paid": qn.docs[i]["paid"],
            "postId": qn.docs[i]["postId"]

            // "userName": qn.docs[i]["userName"],
          });
        }
      }
    });
  }
}
