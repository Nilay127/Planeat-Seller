import 'dart:io';

import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '/Config/config.dart';
import '/DialogBox/errorDialog.dart';
import '/DialogBox/loadingDialog.dart';
import '/Screen/home.dart';

import '/Widgets/color.dart';
import 'package:image_picker/image_picker.dart';

class Updateprofile extends StatefulWidget {
  @override
  _UpdateprofileState createState() => _UpdateprofileState();
}

class _UpdateprofileState extends State<Updateprofile> {
  TextEditingController _nametextEditingController = TextEditingController();

  TextEditingController _phonetextEditingController = TextEditingController();
  TextEditingController _addresstextEditingController = TextEditingController();
  // String userImageUrl = "";
  // late File _imageFile;
  bool uploading = false;

  uploadToStorage() async {
    setState(() {
      uploading = true;
    });

    showDialog(
        context: context,
        builder: (c) {
          return LoadingAlertDialog(
            message: "'Updating, Please wait.....'",
          );
        });
    String imageFileName = DateTime.now().millisecondsSinceEpoch.toString();

    Reference storageReference =
        FirebaseStorage.instance.ref().child(imageFileName);
    saveUserInfoToFireStore(EcommerceApp.user!).then((value) {
      Route route = MaterialPageRoute(builder: (_) => UploadPage());
      Navigator.pushReplacement(context, route);
      showDialog(
          context: context,
          builder: (context) {
            return ErrorAlertDialog(
              message: "Profile Updated",
            );
          });
    });
  }

  displayDialog(String msg) {
    showDialog(
        context: context,
        builder: (c) {
          return ErrorAlertDialog(
            message: msg,
          );
        });
  }

  Future saveUserInfoToFireStore(User fUser) async {
    FirebaseFirestore.instance
        .collection("serviceprovider")
        .doc(EcommerceApp.sharedPreferences.getString(EcommerceApp.userUID))
        .update({
      "uid": EcommerceApp.sharedPreferences.getString(EcommerceApp.userUID),
      "email": EcommerceApp.sharedPreferences.getString(EcommerceApp.userEmail),
      "Kitchen Name":
          EcommerceApp.sharedPreferences.getString(EcommerceApp.userName),
      "password":
          EcommerceApp.sharedPreferences.getString(EcommerceApp.userpassword),
      "Mobile_no":
          EcommerceApp.sharedPreferences.getString(EcommerceApp.userphone),
      "Address":
          EcommerceApp.sharedPreferences.getString(EcommerceApp.addressID),
    });
    setState(() {
      uploading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    _nametextEditingController.text =
        EcommerceApp.sharedPreferences.getString(EcommerceApp.userName)!;

    _phonetextEditingController.text =
        EcommerceApp.sharedPreferences.getString(EcommerceApp.userphone)!;
    _addresstextEditingController.text =
        EcommerceApp.sharedPreferences.getString(EcommerceApp.addressID)!;
    var screenwidth = MediaQuery.of(context).size.width;
    var screenheight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        flexibleSpace: Container(
          decoration: new BoxDecoration(color: carrotOrange),
        ),
        title: Text(
          "Update Profile",
          style: TextStyle(color: valhalla),
        ),
      ),
      body: uploading
          ? LoadingAlertDialog(
              message: "Uploading....",
            )
          : ListView(
              children: [
                SizedBox(
                  height: 8.0,
                ),
                // Center(
                //   child: Container(
                //     height: screenwidth / 2 - 20.0,
                //     width: screenwidth / 2 - 20.0,
                //     decoration: BoxDecoration(
                //         borderRadius: BorderRadius.circular(100.0)),
                //     child: CircleAvatar(
                //       backgroundImage: NetworkImage(
                //         EcommerceApp.sharedPreferences
                //             .getString(EcommerceApp.userAvatarUrl),
                //       ),
                //     ),
                //   ),
                // ),
                // Padding(
                //   padding: const EdgeInsets.all(8.0),
                //   child: Center(
                //     child: TextButton(
                //       onPressed: () async {
                //         _imageFile = await ImagePicker.pickImage(
                //             source: ImageSource.gallery);
                //       },
                //       // color: tyrianPurple,
                //       // shape: RoundedRectangleBorder(
                //       //     borderRadius: BorderRadius.circular(9.0)),
                //       child: Text(
                //         AppLocalizations.of(context)!.selectimage,
                //         style: TextStyle(
                //           color: white,
                //           fontSize: 15.0,
                //           fontWeight: FontWeight.bold,
                //         ),
                //       ),
                //     ),
                //   ),
                // ),
                Padding(
                  padding:
                      const EdgeInsets.only(left: 15.0, right: 10.0, top: 10.0),
                  child: Text(
                    "Kitchen Name",
                    style: TextStyle(
                      color: tyrianPurple,
                      fontSize: 19.0,
                    ),
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.only(left: 15.0, right: 10.0, top: 5.0),
                  child: TextField(
                    cursorColor: valhalla,
                    decoration: InputDecoration(
                      focusColor: Theme.of(context).primaryColor,
                    ),
                    controller: _nametextEditingController,
                    onChanged: (text) {
                      EcommerceApp.sharedPreferences
                          .setString(EcommerceApp.userName, text);
                    },
                  ),
                ),
                // Padding(
                //   padding: const EdgeInsets.only(left: 10.0, right: 10.0, top: 10.0),
                //   child: Text("Email ",
                //       style: TextStyle(
                //         color: tyrianPurple,
                //         fontSize: 20.0,
                //       )),
                // ),
                // Padding(
                //   padding: const EdgeInsets.only(left: 10.0, right: 10.0, top: 5.0),
                //   child: TextField(
                //     cursorColor: valhalla,
                //     decoration: InputDecoration(
                //       focusColor: Theme.of(context).primaryColor,
                //     ),
                //     controller: _emailtextEditingController,
                //     onChanged: (text) {
                //       EcommerceApp.sharedPreferences
                //           .setString(EcommerceApp.userEmail, text);
                //     },
                //   ),
                // ),
                Padding(
                  padding:
                      const EdgeInsets.only(left: 15.0, right: 10.0, top: 10.0),
                  child: Text("Mobile No.",
                      style: TextStyle(color: tyrianPurple, fontSize: 19.0)),
                ),
                Padding(
                  padding:
                      const EdgeInsets.only(left: 15.0, right: 10.0, top: 5.0),
                  child: TextField(
                    decoration: InputDecoration(
                      focusColor: Theme.of(context).primaryColor,
                    ),
                    cursorColor: valhalla,
                    controller: _phonetextEditingController,
                    keyboardType:
                        TextInputType.numberWithOptions(decimal: true),
                    inputFormatters: [
                      // WhitelistingTextInputFormatter(new RegExp(('[0-9]'))),
                      LengthLimitingTextInputFormatter(10),
                    ],
                    onChanged: (text) {
                      EcommerceApp.sharedPreferences
                          .setString(EcommerceApp.userphone, text);
                    },
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.only(left: 15.0, right: 10.0, top: 10.0),
                  child: Text("Address",
                      style: TextStyle(color: tyrianPurple, fontSize: 19.0)),
                ),
                Padding(
                  padding:
                      const EdgeInsets.only(left: 15.0, right: 10.0, top: 5.0),
                  child: TextField(
                    cursorColor: valhalla,
                    decoration: InputDecoration(
                      focusColor: Theme.of(context).primaryColor,
                    ),
                    controller: _addresstextEditingController,
                    onChanged: (text) {
                      EcommerceApp.sharedPreferences
                          .setString(EcommerceApp.addressID, text);
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Center(
                    child: Container(
                      width: screenwidth - 50.0,
                      child: TextButton(
                        onPressed: () {
                          _nametextEditingController.text.isNotEmpty &&
                                  _phonetextEditingController.text.isNotEmpty &&
                                  _addresstextEditingController.text.isNotEmpty
                              ? _phonetextEditingController.text.length == 10
                                  ? uploadToStorage()
                                  : displayDialog(
                                      "Please write correct phone number")
                              : displayDialog(
                                  "Please fill up the required details");
                        },
                        style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all<Color>(tyrianPurple)),

                        // color: tyrianPurple,
                        // shape: RoundedRectangleBorder(
                        //     borderRadius: BorderRadius.circular(9.0)),
                        child: Text(
                          "Update",
                          style: TextStyle(
                            color: white,
                            fontSize: 15.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
    );
  }
}
