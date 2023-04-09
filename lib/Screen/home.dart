import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:new_tiffin_seller/Authentication/login.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../Authentication/authenication.dart';
import '../Config/config.dart';

import '../DialogBox/errorDialog.dart';
import '../Screen/contactus.dart';
import '../Screen/menueditor.dart';
import '../Screen/orders.dart';
import '../Screen/profile.dart';

import '../Widgets/color.dart';
import '../Widgets/loadingWidget.dart';

import '../Widgets/myDrawer.dart';
// import 'package:e_shop/Admin/adminShiftOrders.dart';
// import 'package:e_shop/Widgets/loadingWidget.dart';
import '../main.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
// import 'package:image/image.dart' as ImD;

class UploadPage extends StatefulWidget {
  @override
  _UploadPageState createState() => _UploadPageState();
}

class _UploadPageState extends State<UploadPage>
    with AutomaticKeepAliveClientMixin<UploadPage> {
  bool get wantKeepAlive => true;
  late File file;

  // String productId = getproductid();

  late bool available;

  bool uploading = false;
  int _selectedIndex = 0;
  final List<Widget> _children = [
    // Login(),
    // Login(),
   
    Orders(),
    MenuEditor(),
    Profile(),
  ];

//  bool getdata() async {
//    var x=await Firestore.instance.collection('serviceprovider').document(EcommerceApp.sharedPreferences.getString(EcommerceApp.userUID)).get();
//
//    var y=x.data['available'];
//    return y;
//  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void toggleSwitch(bool value) {
    if (EcommerceApp.sharedPreferences.getBool(EcommerceApp.kitchenstatus) ==
        false) {
      setState(() {
        available = true;
        EcommerceApp.sharedPreferences
            .setBool(EcommerceApp.kitchenstatus, true);
        FirebaseFirestore.instance
            .collection("serviceprovider")
            .doc(
                EcommerceApp.sharedPreferences.getString(EcommerceApp.userUID))
            .update({'available': true});
      });
      print('Switch Button is ON');
      print(EcommerceApp.sharedPreferences.getBool(EcommerceApp.kitchenstatus));
      showDialog(
          context: context,
          builder: (context) {
            return ErrorAlertDialog(
              message: "You Are Available",
            );
          });
    } else {
      setState(() {
        available = false;
        EcommerceApp.sharedPreferences
            .setBool(EcommerceApp.kitchenstatus, false);
        FirebaseFirestore.instance
            .collection("serviceprovider")
            .doc(
                EcommerceApp.sharedPreferences.getString(EcommerceApp.userUID))
            .update({'available': false});
      });
      print('Switch Button is OFF');

      showDialog(
          context: context,
          builder: (context) {
            return ErrorAlertDialog(
              message: "You Are Not Available",
            );
          });
    }
  }

  @override
  Widget build(BuildContext context) {
    var screenwidth = MediaQuery.of(context).size.width;

    final List<String> _appbartitle = [
      "Manage order",
      "Your Weekly Menu",
      "Profile"
    ];
    return Scaffold(
      appBar: AppBar(
        // automaticallyImplyLeading: false,
        title: Text(_appbartitle[_selectedIndex],
            style: TextStyle(
              color: valhalla,
            )),
        iconTheme: IconThemeData(color: Colors.black),
        flexibleSpace: Container(
          decoration: new BoxDecoration(color: carrotOrange),
        ),
        actions: [
          Container(
            width: screenwidth / 3,
            child: Row(mainAxisAlignment: MainAxisAlignment.start, children: [
              Text(
                "Acailable",
                style: TextStyle(color: valhalla),
              ),
              Switch(
                onChanged: toggleSwitch,
                value: EcommerceApp.sharedPreferences
                    .getBool(EcommerceApp.kitchenstatus)??false,
                activeColor: Colors.green,
                activeTrackColor: Colors.lightGreenAccent,
                inactiveThumbColor: Colors.redAccent,
                inactiveTrackColor: Colors.red,
              )
            ]),
          ),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
                child: Image.asset(
              "images/Plan.png",
              fit: BoxFit.cover,
            )),
            ListTile(
              leading: Icon(
                Icons.home,
                color: valhalla,
              ),
              title: Text("Home"),
              onTap: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => UploadPage()),
                );
              },
            ),
            ListTile(
              leading: Icon(
                Icons.contact_mail,
                color: valhalla,
              ),
              title: Text("Contact Us"),
              onTap: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => ContactUs()),
                );
              },
            ),
            ListTile(
              leading: Icon(
                Icons.logout,
                color: valhalla,
              ),
              title: Text("Logout"),
              onTap: () async {
                await EcommerceApp.sharedPreferences
                    .remove(EcommerceApp.userUID);
                await EcommerceApp.sharedPreferences
                    .remove(EcommerceApp.weekday);
                await EcommerceApp.sharedPreferences
                    .remove(EcommerceApp.mealtime);
                await EcommerceApp.sharedPreferences
                    .remove(EcommerceApp.avg_rating);

                await EcommerceApp.sharedPreferences
                    .remove(EcommerceApp.userEmail);
                await EcommerceApp.sharedPreferences
                    .remove(EcommerceApp.userpassword);
                await EcommerceApp.sharedPreferences
                    .remove(EcommerceApp.userName);
                await EcommerceApp.sharedPreferences
                    .remove(EcommerceApp.userAvatarUrl);

                EcommerceApp.auth.signOut().then((c) {
                  Navigator.of(context).pushNamedAndRemoveUntil(
                      '/auth', (Route<dynamic> route) => false);
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content:
                        Text("Logout successfully"),
                  ));
                });
              },
            ),
          ],
        ),
      ),
      body: _children[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        // this will be set when a new tab is tapped
        backgroundColor: carrotOrange,
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(
            icon: new Icon(Icons.food_bank),
            label: "Order"
            // title: new Text(AppLocalizations.of(context)!.order),
          ),
          BottomNavigationBarItem(
            icon: new Icon(Icons.menu_book),
            label: "Menu Editor"
            // title: new Text(AppLocalizations.of(context)!.menueditor),
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: "Profile",)
              // title: Text()
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: valhalla,
        selectedLabelStyle: TextStyle(fontWeight: FontWeight.bold),
        onTap: _onItemTapped,
      ),
    );
  }
}
