import 'package:flutter/material.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';
import '../Config/config.dart';
import '../Screen/rating/rating.dart';
import '../Screen/updatingscreen/updateprofile.dart';
import '../Widgets/color.dart';


class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    var screenwidth = MediaQuery.of(context).size.width;
    var screenheight = MediaQuery.of(context).size.height;
    return SingleChildScrollView(
      child: Container(
        child: Center(
          child: Column(
            children: [
              SizedBox(
                height: 10.0,
              ),
              Container(
                height: screenwidth / 2 - 10.0,
                width: screenwidth / 2 - 10.0,
                decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(100.0)),
                child: CircleAvatar(
                  backgroundImage: NetworkImage(
                   EcommerceApp.sharedPreferences
                        .getString(EcommerceApp.userAvatarUrl).toString()),
                ),
              ),
              // Text(
              //   "Your Logo",
              //   style: TextStyle(color: valhalla, fontSize: 20.0),
              // ),
              SizedBox(
                height: 10.0,
              ),
              EcommerceApp.sharedPreferences
                          .getDouble(EcommerceApp.avg_rating) !=
                      null
                  ? SmoothStarRating(
                      rating: EcommerceApp.sharedPreferences
                          .getDouble(EcommerceApp.avg_rating),
                      color: tyrianPurple,
                      borderColor: tyrianPurple,
                      size: 40.0,
                      isReadOnly: true,
                    )
                  : Text(""),
              SizedBox(
                height: 4.0,
              ),
              Padding(
                padding:
                    const EdgeInsets.only(left: 16.0, right: 16.0, top: 8.0),
                child: Card(
                  child: SizedBox(
                    width: screenwidth,
                    child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Kitchen Name",
                              style: TextStyle(
                                color: tyrianPurple,
                                fontSize: 17.0,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 10.0),
                              child: Container(
                                child: Text(
                                    EcommerceApp.sharedPreferences
                                        .getString(EcommerceApp.userName).toString(),
                                    overflow: TextOverflow.clip,
                                    softWrap: true,
                                    style: TextStyle(
                                      color: valhalla,
                                      fontSize: 19.0,
                                    )),
                              ),
                            )
                          ],
                        )),
                  ),
                ),
              ),
              SizedBox(
                height: 8.0,
              ),
              Padding(
                padding:
                    const EdgeInsets.only(left: 16.0, right: 16.0, top: 8.0),
                child: Card(
                  child: SizedBox(
                    width: screenwidth,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Email",
                              style: TextStyle(
                                color: tyrianPurple,
                                fontSize: 17.0,
                              )),
                          Padding(
                            padding: const EdgeInsets.only(top: 10.0),
                            child: Container(
                              child: Text(
                                  EcommerceApp.sharedPreferences
                                      .getString(EcommerceApp.userEmail).toString(),
                                  overflow: TextOverflow.clip,
                                  softWrap: true,
                                  style: TextStyle(
                                    color: valhalla,
                                    fontSize: 19.0,
                                  )),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 8.0,
              ),
              Padding(
                padding:
                    const EdgeInsets.only(left: 16.0, right: 16.0, top: 8.0),
                child: Card(
                  child: SizedBox(
                    width: screenwidth,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Phone",
                              style: TextStyle(
                                  color: tyrianPurple, fontSize: 17.0)),
                          Padding(
                            padding: const EdgeInsets.only(top: 10.0),
                            child: Container(
                              child: Text(
                                  "+1" +
                                      " " +
                                      EcommerceApp.sharedPreferences
                                          .getString(EcommerceApp.userphone).toString(),
                                  overflow: TextOverflow.clip,
                                  softWrap: true,
                                  style: TextStyle(
                                    color: valhalla,
                                    fontSize: 19.0,
                                  )),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 8.0,
              ),
              Padding(
                padding: const EdgeInsets.only(
                    left: 16.0, right: 16.0, top: 8.0, bottom: 10.0),
                child: Card(
                  child: SizedBox(
                    width: screenwidth,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Address",
                              style: TextStyle(
                                  color: tyrianPurple, fontSize: 17.0)),
                          Padding(
                            padding: const EdgeInsets.only(top: 10.0),
                            child: Container(
                              child: Text(
                                  EcommerceApp.sharedPreferences
                                      .getString(EcommerceApp.addressID).toString(),
                                  overflow: TextOverflow.clip,
                                  softWrap: true,
                                  style: TextStyle(
                                    color: valhalla,
                                    fontSize: 19.0,
                                  )),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              // Container(
              //   width: screenwidth - 50.0,
              //   decoration: BoxDecoration(
              //       borderRadius: BorderRadius.circular(10.0),
              //       color: tyrianPurple),
              //   child: TextButton(
              //     onPressed: () {
              //       Navigator.push(
              //         context,
              //         MaterialPageRoute(builder: (context) => Updateprofile()),
              //       );
              //     },
              //     child: Text(
              //       "Update Profile",
              //       style: TextStyle(
              //           color: white,
              //           fontSize: 15.0,
              //           fontWeight: FontWeight.bold),
              //     ),
              //   ),
              // ),

              // Padding(
              //   padding: const EdgeInsets.all(12.0),
              //   child: Container(
              //     decoration: BoxDecoration(
              //         borderRadius: BorderRadius.circular(10.0),
              //         color: tyrianPurple),
              //     width: screenwidth - 50.0,
              //     child: TextButton(
              //       onPressed: () {
              //         Navigator.push(
              //           context,
              //           MaterialPageRoute(builder: (context) => Rating()),
              //         );
              //       },
              //       child: Text(
              //         "See your reviewa",
              //         style: TextStyle(
              //             color: white,
              //             fontSize: 15.0,
              //             fontWeight: FontWeight.bold),
              //       ),
              //     ),
              //   ),
              // ),
            
            ],
          ),
        ),
      ),
    );
  }
}
