import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';
import '/Config/config.dart';
import '/Widgets/color.dart';
import '/Widgets/loadingWidget.dart';


class Rating extends StatefulWidget {
  @override
  _RatingState createState() => _RatingState();
}

class _RatingState extends State<Rating> {
  double avg_rating = 5.0;
  var data;
  @override
  Widget build(BuildContext context) {
    var screenwidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        flexibleSpace: Container(
          decoration: new BoxDecoration(color: carrotOrange),
        ),
        title: Text(
          "Your Rating",
          style: TextStyle(color: valhalla),
        ),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection("serviceprovider")
            .doc(
                EcommerceApp.sharedPreferences.getString(EcommerceApp.userUID))
            .collection("ratings")
            .orderBy("publishedDate", descending: true)
            .snapshots(),
        builder: (context, dataSnapshot) {
          if (!dataSnapshot.hasData) {
            return Container(
              child: Center(child: Text("No ratings Till Now")),
            );
          } else {
            return ListView.builder(
                itemCount: dataSnapshot.data!.docs.length,
                itemBuilder: (BuildContext context, int i) {
                  avg_rating = (avg_rating +
                          dataSnapshot.data!.docs[i]['order_rating']) /
                      2;
                  EcommerceApp.sharedPreferences
                      .setDouble(EcommerceApp.avg_rating, avg_rating);
                  FirebaseFirestore.instance
                      .collection('serviceprovider')
                      .doc(EcommerceApp.sharedPreferences
                          .getString(EcommerceApp.userUID))
                      .update({
                    "Avg_rating": avg_rating,
                  });
                  return Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Card(
                      elevation: 2.0,
                      child: Container(
                        width: screenwidth,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 8.0, right: 8.0, top: 8.0),
                              child: Text(
                                "Order id: " +
                                    dataSnapshot
                                        .data!.docs[i]['order_id'],
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 17.0),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 8.0, right: 8.0, top: 8.0),
                              child: Text(
                                "Name" +
                                    ": " +
                                    dataSnapshot
                                        .data!.docs[i]['c_name'],
                                style: TextStyle(fontSize: 17.0),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 8.0, right: 8.0, top: 8.0),
                              child: Row(
                                children: [
                                  Text(
                                    "Rating",
                                    style: TextStyle(fontSize: 17.0),
                                  ),
                                  SmoothStarRating(
                                    rating: dataSnapshot
                                        .data!.docs[i]['order_rating'],
                                    color: tyrianPurple,
                                    borderColor: tyrianPurple,
                                    isReadOnly: true,
                                  )
                                ],
                              ),
                            ),
                            dataSnapshot.data!.docs[i]
                                            ['order_review'] ==
                                        null ||
                                    dataSnapshot.data!.docs[i]
                                            ['order_review'] ==
                                        ""
                                ? Padding(
                                    padding: const EdgeInsets.only(
                                        left: 8.0, right: 8.0, top: 8.0),
                                    child: Text(
                                      "Review : No Review",
                                      style: TextStyle(fontSize: 17.0),
                                    ),
                                  )
                                : Padding(
                                    padding: const EdgeInsets.only(
                                        left: 8.0, right: 8.0, top: 8.0),
                                    child: Text(
                                      "Review : " +
                                          dataSnapshot.data!.docs[i]
                                              ['order_review'],
                                      style: TextStyle(fontSize: 17.0),
                                    ),
                                  ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                DateFormat.yMMMd().add_jm().format(
                                    DateTime.parse(dataSnapshot
                                        .data!.docs[i]['publishedDate']
                                        .toDate()
                                        .toString())),
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 17.0),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                });
          }
        },
      ),
    );
  }
}
