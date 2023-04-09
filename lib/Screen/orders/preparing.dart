// ignore_for_file: prefer_const_constructors, prefer_interpolation_to_compose_strings

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '/Config/config.dart';
import '/DialogBox/errorDialog.dart';
import '/Screen/orders/orderdetails.dart';

import '/Widgets/color.dart';

class Preparing extends StatefulWidget {
  @override
  _PreparingState createState() => _PreparingState();
}

class _PreparingState extends State<Preparing> {
  @override
  Widget build(BuildContext context) {
    var screenwidth = MediaQuery.of(context).size.width;
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection('Orders')
          .orderBy("publishedDate", descending: true)
          .snapshots(),
      builder: (context, dataSnapshot) {
        if (!dataSnapshot.hasData) {
          return Container(
            child: Center(
              child: Column(
                children: [
                  SizedBox(
                    height: 100.0,
                  ),
                  Image.network(
                    'https://icon-library.com/images/no-data-icon/no-data-icon-10.jpg',
                    height: 150.0,
                    width: 150.0,
                    fit: BoxFit.fill,
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  Text(
                   "Orders Being Prepared Will Appear here",
                    style: TextStyle(fontSize: 19.0),
                  )
                ],
              ),
            ),
          );
        } else {
          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "Orders Being Prepared Will Appear here",
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 15.0,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              Expanded(
                child: ListView.builder(
                    itemCount: dataSnapshot.data!.docs.length,
                    itemBuilder: (BuildContext context, int i) {
                      return Column(
                        children: [
                          dataSnapshot.data!.docs[i]['sp_id'] ==
                                  EcommerceApp.sharedPreferences
                                      .getString(EcommerceApp.userUID)
                              ? dataSnapshot.data!.docs[i]
                                          ['order_status'] ==
                                      "2"
                                  ? Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Container(
                                        width: screenwidth,
                                        child: Card(
                                          elevation: 4.0,
                                          child: InkWell(
                                            onTap: () {
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        OrderDetail(
                                                          order: dataSnapshot
                                                              .data!
                                                              .docs[i]
                                                              .data() as Map<String, dynamic>,
                                                          id: dataSnapshot
                                                              .data!
                                                              .docs[i]
                                                              .id,
                                                        )),
                                              );
                                            },
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 10.0,
                                                          right: 10.0,
                                                          top: 10.0),
                                                  child: Text(
                                                    "Order ID: " +
                                                        dataSnapshot
                                                            .data!
                                                            .docs[i]
                                                            .id,
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 15.0),
                                                  ),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: Row(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Container(
                                                        width:
                                                            screenwidth / 1.8,
                                                        child: Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Column(
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .start,
                                                              children: [
                                                                for (int j = 0;
                                                                    j <
                                                                        dataSnapshot
                                                                            .data!
                                                                            .docs[i]
                                                                            ['order_item']
                                                                            .length;
                                                                    j++)
                                                                  Column(
                                                                    crossAxisAlignment:
                                                                        CrossAxisAlignment
                                                                            .start,
                                                                    children: [
                                                                      Padding(
                                                                        padding: const EdgeInsets.only(
                                                                            left:
                                                                                8.0,
                                                                            right:
                                                                                8.0,
                                                                            top:
                                                                                8.0),
                                                                        child:
                                                                            Text(
                                                                          dataSnapshot
                                                                              .data!
                                                                              .docs[i]
                                                                              ['order_item'][j]['order_itemtitle'],
                                                                          style: TextStyle(
                                                                              color: tyrianPurple,
                                                                              fontWeight: FontWeight.bold,
                                                                              fontSize: 15.0),
                                                                        ),
                                                                      ),
                                                                      Padding(
                                                                        padding: const EdgeInsets.only(
                                                                            left:
                                                                                8.0,
                                                                            right:
                                                                                8.0,
                                                                            top:
                                                                                8.0),
                                                                        child:
                                                                            Text(
                                                                          "Quantity : " +
                                                                              dataSnapshot.data!.docs[i]['order_item'][j]['order_itemquantity'].toString(),
                                                                          style:
                                                                              TextStyle(fontSize: 15.0),
                                                                        ),
                                                                      ),
                                                                    ],
                                                                  ),
                                                              ],
                                                            ),
                                                            Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                          .only(
                                                                      left: 8.0,
                                                                      right:
                                                                          8.0,
                                                                      top: 8.0),
                                                              child: Text(
                                                                "\$" +
                                                                    dataSnapshot
                                                                        .data!
                                                                        .docs[
                                                                            i]
                                                                        [
                                                                            'order_totalprice']
                                                                        .toString(),
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        15.0),
                                                              ),
                                                            ),
                                                            Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                          .only(
                                                                      left: 8.0,
                                                                      right:
                                                                          8.0,
                                                                      top: 8.0),
                                                              child: Text(
                                                               "Time : " +
                                                                    dataSnapshot
                                                                        .data!
                                                                        .docs[
                                                                            i]
                                                                        ['time_slot'],
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        15.0),
                                                              ),
                                                            ),
                                                            Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                          .only(
                                                                      left: 8.0,
                                                                      right:
                                                                          8.0,
                                                                      top: 8.0),
                                                              child: Text(
                                                                "Address" +
                                                                    " " +
                                                                    dataSnapshot
                                                                        .data!
                                                                        .docs[
                                                                            i]
                                                                        ['c_address'],
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        15.0),
                                                              ),
                                                            )
                                                          ],
                                                        ),
                                                      ),
                                                      Container(
                                                        width: screenwidth / 4,
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                      .only(
                                                                  left: 8.0,
                                                                  top: 8.0),
                                                          child: Column(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .start,
                                                            children: [
                                                              Text(
                                                               "Order Status",
                                                                style:
                                                                    TextStyle(
                                                                  fontSize:
                                                                      15.0,
                                                                ),
                                                              ),
                                                              Text(
                                                               "Preparing",
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        15.0,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold),
                                                              ),
                                                              SizedBox(
                                                                height: 50.0,
                                                              ),
                                                              Text(
                                                                DateFormat
                                                                        .yMMMd()
                                                                    .add_jm()
                                                                    .format(DateTime.parse(dataSnapshot
                                                                        .data!
                                                                        .docs[
                                                                            i]
                                                                        [
                                                                            'publishedDate']
                                                                        .toDate()
                                                                        .toString())),
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        15.0,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: Center(
                                                    child: Container(
                                                      width: screenwidth / 2,
                                                      decoration: BoxDecoration(
                                                          border: Border.all(
                                                              color: valhalla),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      4.0)),
                                                      child: TextButton(
                                                          onPressed: () {
                                                            showDialog(
                                                                context:
                                                                    context,
                                                                builder:
                                                                    (context) {
                                                                  return ErrorAlertDialog(
                                                                    message: "Order"+
                                                                        " " +
                                                                        dataSnapshot
                                                                            .data!
                                                                            .docs[
                                                                                i]
                                                                            .id +
                                                                        " " +
                                                                       "Given for Delivery", 
                                                                  );
                                                                });
                                                            FirebaseFirestore.instance
                                                                .collection(
                                                                    'Orders')
                                                                .doc(dataSnapshot
                                                                    .data!
                                                                    .docs[
                                                                        i]
                                                                    .id)
                                                                .update({
                                                              "order_status":
                                                                  "4"
                                                            });
                                                          },
                                                          child: Text(
                                                              "Given for Delivery")),
                                                    ),
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    )
                                  : dataSnapshot.data!.docs[i]
                                              ['order_status'] ==
                                          "4"
                                      ? Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Container(
                                            width: screenwidth,
                                            child: Card(
                                              elevation: 4.0,
                                              child: InkWell(
                                                onTap: () {
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            OrderDetail(
                                                              order: dataSnapshot
                                                                  .data!
                                                                  .docs[i]
                                                                  .data() as Map<String, dynamic>,
                                                              id: dataSnapshot
                                                                  .data!
                                                                  .docs[i]
                                                                  .id,
                                                            )),
                                                  );
                                                },
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              left: 10.0,
                                                              right: 10.0,
                                                              top: 10.0),
                                                      child: Text(
                                                      "Order ID: " +
                                                            dataSnapshot
                                                                .data!
                                                                .docs[i]
                                                                .id,
                                                        style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            fontSize: 15.0),
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              8.0),
                                                      child: Row(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                          Container(
                                                            width: screenwidth /
                                                                1.8,
                                                            child: Column(
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .start,
                                                              children: [
                                                                Column(
                                                                  crossAxisAlignment:
                                                                      CrossAxisAlignment
                                                                          .start,
                                                                  children: [
                                                                    for (int j =
                                                                            0;
                                                                        j < dataSnapshot.data!.docs[i]['order_item'].length;
                                                                        j++)
                                                                      Column(
                                                                        crossAxisAlignment:
                                                                            CrossAxisAlignment.start,
                                                                        children: [
                                                                          Padding(
                                                                            padding: const EdgeInsets.only(
                                                                                left: 8.0,
                                                                                right: 8.0,
                                                                                top: 8.0),
                                                                            child:
                                                                                Text(
                                                                              dataSnapshot.data!.docs[i]['order_item'][j]['order_itemtitle'],
                                                                              style: TextStyle(color: tyrianPurple, fontWeight: FontWeight.bold, fontSize: 15.0),
                                                                            ),
                                                                          ),
                                                                          Padding(
                                                                            padding: const EdgeInsets.only(
                                                                                left: 8.0,
                                                                                right: 8.0,
                                                                                top: 8.0),
                                                                            child:
                                                                                Text(
                                                                              "Quantity" + dataSnapshot.data!.docs[i]['order_item'][j]['order_itemquantity'].toString(),
                                                                              style: TextStyle(fontSize: 15.0),
                                                                            ),
                                                                          ),
                                                                        ],
                                                                      ),
                                                                  ],
                                                                ),
                                                                Padding(
                                                                  padding: const EdgeInsets
                                                                          .only(
                                                                      left: 8.0,
                                                                      right:
                                                                          8.0,
                                                                      top: 8.0),
                                                                  child: Text(
                                                                    "\$" +
                                                                        dataSnapshot
                                                                            .data!
                                                                            .docs[i]
                                                                            ['order_totalprice']
                                                                            .toString(),
                                                                    style: TextStyle(
                                                                        fontSize:
                                                                            15.0),
                                                                  ),
                                                                ),
                                                                Padding(
                                                                  padding: const EdgeInsets
                                                                          .only(
                                                                      left: 8.0,
                                                                      right:
                                                                          8.0,
                                                                      top: 8.0),
                                                                  child: Text(
                                                                   "Time" +
                                                                        dataSnapshot
                                                                            .data!
                                                                            .docs[i]
                                                                            ['time_slot'],
                                                                    style: TextStyle(
                                                                        fontSize:
                                                                            15.0),
                                                                  ),
                                                                ),
                                                                Padding(
                                                                  padding: const EdgeInsets
                                                                          .only(
                                                                      left: 8.0,
                                                                      right:
                                                                          8.0,
                                                                      top: 8.0),
                                                                  child: Text(
                                                                    "Address"+
                                                                        ": " +
                                                                        dataSnapshot
                                                                            .data!
                                                                            .docs[i]
                                                                            ['c_address'],
                                                                    style: TextStyle(
                                                                        fontSize:
                                                                            15.0),
                                                                  ),
                                                                )
                                                              ],
                                                            ),
                                                          ),
                                                          Container(
                                                            width:
                                                                screenwidth / 4,
                                                            child: Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                          .only(
                                                                      left: 8.0,
                                                                      top: 8.0),
                                                              child: Column(
                                                                crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .start,
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .start,
                                                                children: [
                                                                  Text(
                                                                   "Order Status",
                                                                    style:
                                                                        TextStyle(
                                                                      fontSize:
                                                                          15.0,
                                                                    ),
                                                                  ),
                                                                  Text(
                                                                   "Out For Delivery",
                                                                    style: TextStyle(
                                                                        fontSize:
                                                                            15.0,
                                                                        fontWeight:
                                                                            FontWeight.bold),
                                                                  ),
                                                                  SizedBox(
                                                                    height:
                                                                        50.0,
                                                                  ),
                                                                  Text(
                                                                    DateFormat.yMMMd().add_jm().format(DateTime.parse(dataSnapshot
                                                                        .data!
                                                                        .docs[
                                                                            i]
                                                                       [
                                                                            'publishedDate']
                                                                        .toDate()
                                                                        .toString())),
                                                                    style: TextStyle(
                                                                        fontWeight:
                                                                            FontWeight.bold),
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                          )
                                                        ],
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              8.0),
                                                      child: Center(
                                                        child: Container(
                                                          width:
                                                              screenwidth / 2,
                                                          decoration: BoxDecoration(
                                                              border: Border.all(
                                                                  color:
                                                                      valhalla),
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          4.0)),
                                                          child: TextButton(
                                                              onPressed: () {
                                                                showDialog(
                                                                    context:
                                                                        context,
                                                                    builder:
                                                                        (context) {
                                                                      return ErrorAlertDialog(
                                                                        message:"Order" +
                                                                            " " +
                                                                            dataSnapshot.data!.docs[i].id +
                                                                            " " +
                                                                            "Delivered",
                                                                      );
                                                                    });
                                                                FirebaseFirestore
                                                                    .instance
                                                                    .collection(
                                                                        'Orders')
                                                                    .doc(dataSnapshot
                                                                        .data!
                                                                        .docs[
                                                                            i]
                                                                        .id)
                                                                    .update({
                                                                  "order_status":
                                                                      "5"
                                                                });
                                                                FirebaseFirestore
                                                                    .instance
                                                                    .collection(
                                                                        'Orders')
                                                                    .doc(dataSnapshot
                                                                        .data!
                                                                        .docs[
                                                                            i]
                                                                        .id)
                                                                    .update({
                                                                  "payment_status":
                                                                      "Done"
                                                                });
                                                              },
                                                              child: Text(
                                                                  "Delivered")),
                                                        ),
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                        )
                                      : Padding(padding: EdgeInsets.all(0.0))
                              : Padding(padding: EdgeInsets.all(0.0)),
                        ],
                      );
                    }),
              ),
            ],
          );
        }
      },
    );
  }
}
