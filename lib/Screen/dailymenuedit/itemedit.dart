import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import '/Config/config.dart';
import '/DialogBox/errorDialog.dart';
import '/Screen/home.dart';
import '/Widgets/color.dart';

import '/Widgets/loadingWidget.dart';

class ItemEdit extends StatefulWidget {
  final Map<dynamic, dynamic> item;
  final String id;
  ItemEdit({required this.item, required this.id});
  @override
  _ItemEditState createState() => _ItemEditState();
}

class _ItemEditState extends State<ItemEdit> {
  TextEditingController _menuitem = TextEditingController();
  TextEditingController _price = TextEditingController();
  TextEditingController _description = TextEditingController();
  var file;

  var b;
  String menu_id = DateTime.now().millisecondsSinceEpoch.toString();

  clearFormInfo() {
    setState(() {
      file = null;
      b = null;
      _menuitem.clear();
      _price.clear();
      _description.clear();
    });
  }

  Future<void> uploadImageAndSaveItemInfo() async {
    if (b == null) {
      saveItemInfo(file);
    } else {
      String imageDownloadUrl = await uploadItemImage(b);

      saveItemInfo(imageDownloadUrl);
    }
  }

  Future<void> _selectandPickImage() async {
    var imagefile = await ImagePicker().pickImage(source: ImageSource.gallery);

    setState(() {
      b = imagefile;
    });
  }

  Future<String> uploadItemImage(mFileImage) async {
    final Reference storageReference =
        FirebaseStorage.instance.ref().child("dailymenu");
    UploadTask uploadTask =
        storageReference.child("menu_$menu_id.jpg").putFile(mFileImage);
    TaskSnapshot taskSnapshot = await uploadTask;
    String downloadUrl = await taskSnapshot.ref.getDownloadURL();
    return downloadUrl;
  }

  saveItemInfo(String downloadUrl) {
    final itemsRef = FirebaseFirestore.instance.collection("serviceprovider");
    itemsRef
        .doc(
            EcommerceApp.sharedPreferences.getString(EcommerceApp.userUID))
        .collection("dailymenu")
        .doc(widget.id)
        .set({
      "title": widget.item["title"],
      "Description": widget.item["Description"],
      "price": widget.item["price"],
      "publishedDate": DateTime.now(),
      "status": true,
      "thumbnailUrl": downloadUrl,
      "uid": EcommerceApp.sharedPreferences.getString(EcommerceApp.userUID),
    });

    setState(() {
      file = null;
      // uploading = false;
      // productId = DateTime.now().millisecondsSinceEpoch.toString();
      menu_id = DateTime.now().millisecondsSinceEpoch.toString();
      _menuitem.clear();
      _price.clear();
      _description.clear();
      // loading = false;
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

    file = widget.item['thumbnailUrl'];
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            // clearFormInfo();
            Navigator.pop(context);
          },
        ),
        flexibleSpace: Container(
          decoration: new BoxDecoration(color: carrotOrange),
        ),
        title: Text(
          "Edit Item",
          style: TextStyle(color: valhalla),
        ),
      ),
      body: Container(
        child: ListView(
          children: [
            Container(
              height: 230.0,
              width: MediaQuery.of(context).size.width * 0.8,
              child: b == null
                  ? Center(
                      child: AspectRatio(
                        aspectRatio: 16 / 9,
                        child: Container(
                          child: Image.network(
                            file,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    )
                  : Center(
                      child: AspectRatio(
                        aspectRatio: 16 / 9,
                        child: Container(
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: FileImage(b), fit: BoxFit.cover)),
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
                    // print(EcommerceApp.sharedPreferences
                    //     .getString(EcommerceApp.mealtime));
                    // print(EcommerceApp.sharedPreferences
                    //     .getString(EcommerceApp.weekday));
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
                child: TextFormField(
                  style: TextStyle(color: valhalla),
                  initialValue: widget.item['title'],
                  // controller: _menuitem,
                  onChanged: (value) {
                    setState(() {
                      widget.item['title'] = value;
                    });
                  },
                  decoration: InputDecoration(
                    hintText:"Title",
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
                child: TextFormField(
                  style: TextStyle(color: valhalla),
                  initialValue: widget.item['price'].toString(),
                  // controller: _price,
                  onChanged: (value) {
                    setState(() {
                      widget.item['price'] = value;
                    });
                  },
                  keyboardType: TextInputType.numberWithOptions(decimal: true),
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
                child: TextFormField(
                  style: TextStyle(color: valhalla),
                  // controller: _description,
                  initialValue: widget.item["Description"],
                  onChanged: (value) {
                    setState(() {
                      widget.item["Description"] = value;
                    });
                  },
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
                    widget.item["Description"] != "" &&
                            widget.item["price"] != "" &&
                            widget.item["title"] != ""
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
                                message:"You have not added the menu",
                              );
                            });
                  },
                  // color: tyrianPurple,
                  // shape: RoundedRectangleBorder(
                  //     borderRadius: BorderRadius.circular(9.0)),
                  child: Text(
                    "Edit",
                    style: TextStyle(
                      color: white,
                      fontSize: 15.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.only(left: 10.0, right: 10.0, bottom: 10.0),
              child: Container(
                width: screenwidth - 100.0,
                child: TextButton(
                   style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all<Color>(tyrianPurple)),
                  onPressed: () {
                    showDialog(
                        context: context,
                        builder: (c) {
                          return AlertDialog(
                            content:
                                Text("Are you sure you want to delete"),
                            actions: <Widget>[
                              TextButton(
                                 style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all<Color>(Colors.red)),
                                onPressed: () {
                                  FirebaseFirestore.instance
                                      .collection("serviceprovider")
                                      .doc(EcommerceApp.sharedPreferences
                                          .getString(EcommerceApp.userUID))
                                      .collection("dailymenu")
                                      .doc(widget.id)
                                      .delete();
                                  Navigator.pop(context);
                                  Navigator.pop(context);
                                },
                                // color: red,
                                child: Center(
                                  child: Text("Yes"),
                                ),
                              ),
                              TextButton(
                                 style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all<Color>(Colors.grey)),
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                // color: green,
                                child: Center(
                                  child: Text("No"),
                                ),
                              ),
                            ],
                          );
                        });
                  },
                  // color: tyrianPurple,
                  // shape: RoundedRectangleBorder(
                  //     borderRadius: BorderRadius.circular(9.0)),
                  child: Text(
                    "Delete",
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
