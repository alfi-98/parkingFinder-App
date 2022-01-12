import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:parking_finder/MVC%20Structure/View/parking_bills.dart';

import '../Controller/upload_parkingspot.dart';
import '../View/parking_address.dart';

class UserDashBoard extends StatelessWidget {
  Items item1 = new Items(
      title: "Driver",
      subtitle: "Search For Parking Space",
      event: "",
      img: "images/car.png");

  Items item2 = new Items(
    title: "Parking Owner",
    subtitle: "Rent your Parking Spot",
    event: "",
    img: "images/park.png",
  );
  Items item3 = new Items(
    title: "Locations",
    subtitle: "Available paking spots",
    event: "",
    img: "images/map.png",
  );
  Items item4 = new Items(
    title: "Billing",
    subtitle: "Pay Your Parking Ticket",
    event: "",
    img: "images/bill.jpeg",
  );
  Items item5 = new Items(
    title: "FeedBack",
    subtitle: "Homework, Design",
    event: "",
    img: "images/feedback.png",
  );
  Items item6 = new Items(
    title: "Settings",
    subtitle: "",
    event: "",
    img: "images/setting.png",
  );

  @override
  Widget build(BuildContext context) {
    List<Items> myList = [item1, item2, item3, item4, item5, item6];
    var color = 0xFF577BC1;
    return Flexible(
      child: GridView.count(
          childAspectRatio: 1.0,
          padding: EdgeInsets.only(left: 16, right: 16),
          crossAxisCount: 2,
          crossAxisSpacing: 18,
          mainAxisSpacing: 18,
          children: myList.map((data) {
            return GestureDetector(
              onTap: () {
                if (data.title == 'Driver') {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => ParkingCard()));
                }
                if (data.title == 'Parking Owner') {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => CreateSpot()));
                }
                if (data.title == 'Billing') {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => ParkingBills()));
                }
              },
              child: Container(
                decoration: BoxDecoration(
                    color: Color(color),
                    borderRadius: BorderRadius.circular(10)),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Image.asset(
                      data.img,
                      width: 42,
                    ),
                    SizedBox(
                      height: 14,
                    ),
                    Text(
                      data.title,
                      style: GoogleFonts.openSans(
                          textStyle: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.w600)),
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Text(
                      data.subtitle,
                      style: GoogleFonts.openSans(
                          textStyle: TextStyle(
                              color: Colors.white38,
                              fontSize: 10,
                              fontWeight: FontWeight.w600)),
                    ),
                    SizedBox(
                      height: 14,
                    ),
                    Text(
                      data.event,
                      style: GoogleFonts.openSans(
                          textStyle: TextStyle(
                              color: Colors.white70,
                              fontSize: 11,
                              fontWeight: FontWeight.w600)),
                    ),
                  ],
                ),
              ),
            );
          }).toList()),
    );
  }
}

class Items {
  String title;
  String subtitle;
  String event;
  String img;
  Items(
      {required this.title,
      required this.subtitle,
      required this.event,
      required this.img});
}
