// import 'dart:html';

import 'dart:io';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '/Config/config.dart';
import '/DialogBox/errorDialog.dart';

import '/DialogBox/loadingDialog.dart';
import '/Screen/home.dart';
import '/Screen/menueditor.dart';
import '/Widgets/color.dart';
import 'package:image_picker/image_picker.dart';
import '/Widgets/loadingWidget.dart';

class Editmenu extends StatefulWidget {
  @override
  _EditmenuState createState() => _EditmenuState();
}

class _EditmenuState extends State<Editmenu>
    with AutomaticKeepAliveClientMixin<Editmenu> {
  bool get wantKeepAlive => true;
  TextEditingController _menuitem = TextEditingController();
  TextEditingController _price = TextEditingController();
  TextEditingController _description = TextEditingController();
  var file;
  bool uploading = false;

  String menu_id = DateTime.now().millisecondsSinceEpoch.toString();

  // takeImage(mContext) {
  //   return showDialog(
  //       context: mContext,
  //       builder: (con) {
  //         return SimpleDialog(
  //           title: Text(
  //             "Item Image",
  //             style:
  //                 TextStyle(color: Colors.green, fontWeight: FontWeight.bold),
  //           ),
  //           children: [
  //             SimpleDialogOption(
  //               child: Text("Capture with Camera",
  //                   style: TextStyle(
  //                     color: Colors.green,
  //                   )),
  //               onPressed: capturePhotoWithCamera,
  //             ),
  //             SimpleDialogOption(
  //               child: Text("Select from Gallery",
  //                   style: TextStyle(
  //                     color: Colors.green,
  //                   )),
  //               onPressed: pickPhotoFromGallery,
  //             ),
  //             SimpleDialogOption(
  //               child: Text("Cancel",
  //                   style: TextStyle(
  //                     color: Colors.green,
  //                   )),
  //               onPressed: () {
  //                 Navigator.pop(context);
  //               },
  //             ),
  //           ],
  //         );
  //       });
  // }

  capturePhotoWithCamera() async {
    Navigator.pop(context);
    var imageFile = await ImagePicker().pickImage(
        source: ImageSource.camera, maxHeight: 680.0, maxWidth: 970.0);

    setState(() {
      file = File(imageFile!.path);
    });
  }

  // pickPhotoFromGallery() async {
  //   Navigator.pop(context);
  //   var imageFile = await ImagePicker.pickImage(
  //     source: ImageSource.gallery,
  //   );

  //   setState(() {
  //     file = imageFile;
  //   });
  // }

  clearFormInfo() {
    setState(() {
      file = null;
      _menuitem.clear();
      _price.clear();
      _description.clear();
    });
  }

  Future<void> uploadImageAndSaveItemInfo() async {
    setState(() {
      uploading = true;
    });
    if (file == null) {
    } else {
      String imageDownloadUrl = await uploadItemImage(file);

      saveItemInfo(imageDownloadUrl);
    }
  }

  Future<void> _selectandPickImage() async {
    var imagefile = await ImagePicker().pickImage(source: ImageSource.gallery);

    setState(() {
      file = File(imagefile!.path);
    });
  }

  Future<String> uploadItemImage(mFileImage) async {
    final Reference storageReference =
        FirebaseStorage.instance.ref().child("weeklymenu");
    UploadTask uploadTask =
        storageReference.child("menu_$menu_id.jpg").putFile(mFileImage);
    TaskSnapshot taskSnapshot = await uploadTask;
    String downloadUrl = await taskSnapshot.ref.getDownloadURL();
    return downloadUrl;
  }

  saveItemInfo(String downloadUrl) {
    final itemsRef = FirebaseFirestore.instance.collection("weeklymenu");
    itemsRef
        .doc(EcommerceApp.sharedPreferences
                .getString(EcommerceApp.userUID)! +
            EcommerceApp.sharedPreferences.getString(EcommerceApp.mealtime)! +
            EcommerceApp.sharedPreferences.getString(EcommerceApp.weekday)!)
        .set({
      "title": _menuitem.text.trim(),
      "Description": _description.text.trim(),
      "price": int.parse(_price.text),
      "publishedDate": DateTime.now(),
      "status": true,
      "thumbnailUrl": downloadUrl,
      "weekday": EcommerceApp.sharedPreferences.getString(EcommerceApp.weekday),
      "mealtime":
          EcommerceApp.sharedPreferences.getString(EcommerceApp.mealtime),
      "uid": EcommerceApp.sharedPreferences.getString(EcommerceApp.userUID),
    });

    setState(() {
      file = null;
      uploading = false;
      // productId = DateTime.now().millisecondsSinceEpoch.toString();
      menu_id = DateTime.now().millisecondsSinceEpoch.toString();
      _menuitem.clear();
      _price.clear();
      _description.clear();
    });
    showDialog(
        context: context,
        builder: (context) {
          return ErrorAlertDialog(
            message: "Menu Added",
          );
        });
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => UploadPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    var screenwidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            clearFormInfo();
            Navigator.pop(context);
          },
        ),
        flexibleSpace: Container(
          decoration: new BoxDecoration(color: carrotOrange),
        ),
        title: Text(
         "Update Menu",
          style: TextStyle(color: valhalla),
        ),
      ),
      body: uploading
          ? LoadingAlertDialog(
              message: "Uploading....",
            )
          : Container(
              child: ListView(
                children: [
                  Container(
                    height: 230.0,
                    width: MediaQuery.of(context).size.width * 0.8,
                    child: file == null
                        ? Center(
                            child: AspectRatio(
                              aspectRatio: 16 / 9,
                              child: Container(
                                decoration: BoxDecoration(),
                              ),
                            ),
                          )
                        : Center(
                            child: AspectRatio(
                              aspectRatio: 16 / 9,
                              child: Container(
                                decoration: BoxDecoration(
                                    image: DecorationImage(
                                        image: FileImage(file),
                                        fit: BoxFit.cover)),
                              ),
                            ),
                          ),
                  ),
                  Padding(padding: EdgeInsets.only(top: 12.0)),
                  Center(
                    child: TextButton(
                       style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all<Color>(tyrianPurple)),
                        // shape: RoundedRectangleBorder(
                        //     borderRadius: BorderRadius.circular(9.0)),
                        child: Text(
                         "Add Image of food",
                          style: TextStyle(
                              fontSize: 15.0,
                              color: white,
                              fontWeight: FontWeight.bold),
                        ),
                        // color: tyrianPurple,
                        onPressed: () {
                          print(EcommerceApp.sharedPreferences
                              .getString(EcommerceApp.mealtime));
                          print(EcommerceApp.sharedPreferences
                              .getString(EcommerceApp.weekday));
                          // showDialog(
                          //     context: context,
                          //     builder: (ctx) => AlertDialog(
                          //           title: Text("Food Dish Image"),
                          //           actions: <Widget>[
                          //             TextButton(
                          //               onPressed: () {
                          //                 _selectandPickImage();
                          //               },
                          //               child: Text("Select From Gallery"),
                          //             ),
                          //             TextButton(
                          //               onPressed: () {
                          //                 capturePhotoWithCamera();
                          //               },
                          //               child: Text("Select From Camera"),
                          //             ),
                          //             TextButton(
                          //               onPressed: () {
                          //                 Navigator.of(ctx).pop();
                          //               },
                          //               child: Text("Cancel"),
                          //             ),
                          //           ],
                          //         ));
                          _selectandPickImage();
                          // takeImage(context);
                        }),
                  ),
                  ListTile(
                    leading: Icon(
                      Icons.menu_open,
                      color: tyrianPurple,
                    ),
                    title: Container(
                      width: 250.0,
                      child: TextField(
                        style: TextStyle(color: valhalla),
                        controller: _menuitem,
                        decoration: InputDecoration(
                          hintText: "Title",
                          hintStyle: TextStyle(color: valhalla),
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                  ),
                  Divider(
                    color: tyrianPurple,
                  ),
                  ListTile(
                    leading: Icon(
                      Icons.money,
                      color: tyrianPurple,
                    ),
                    title: Container(
                      width: 250.0,
                      child: TextField(
                        style: TextStyle(color: valhalla),
                        controller: _price,
                        keyboardType:
                            TextInputType.numberWithOptions(decimal: true),
                        inputFormatters: [
                          // WhitelistingTextInputFormatter(new RegExp(('[0-9.]')))
                        ],
                        decoration: InputDecoration(
                          hintText: "Item Price",
                          hintStyle: TextStyle(color: valhalla),
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                  ),
                  Divider(
                    color: tyrianPurple,
                  ),
                  ListTile(
                    leading: Icon(
                      Icons.perm_device_information,
                      color: tyrianPurple,
                    ),
                    title: Container(
                      width: 250.0,
                      child: TextField(
                        style: TextStyle(color: valhalla),
                        controller: _description,
                        decoration: InputDecoration(
                          hintText: "Description",
                          hintStyle: TextStyle(color: valhalla),
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                  ),
                  Divider(
                    color: tyrianPurple,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Container(
                      width: screenwidth - 100.0,
                      child: TextButton(
                         style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all<Color>(tyrianPurple)),
                        onPressed: () {
                          _menuitem.text.isNotEmpty &&
                                  _description.text.isNotEmpty &&
                                  _price.text.isNotEmpty
                              ? file == null
                                  ? showDialog(
                                      context: context,
                                      builder: (context) {
                                        return ErrorAlertDialog(
                                          message: "Please select an image file.",
                                        );
                                      })
                                  : uploadImageAndSaveItemInfo()
                              : showDialog(
                                  context: context,
                                  builder: (context) {
                                    return ErrorAlertDialog(
                                      message: "You have not added the menu",
                                    );
                                  });
                        },
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
                ],
              ),
            ),
    );
  }
}
