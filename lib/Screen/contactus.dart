import 'package:flutter/material.dart';
import '../Config/config.dart';
import '../Screen/home.dart';

import '../Widgets/color.dart';

import '../Widgets/customTextField.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactUs extends StatefulWidget {
  @override
  _ContactUsState createState() => _ContactUsState();
}

class _ContactUsState extends State<ContactUs> {
  TextEditingController name = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController msg = TextEditingController();
  TextEditingController topic = TextEditingController();

  sendmsg() async {
    var url = "mailto:contacttiffinservice@gmail.com?subject=" +
        topic.text +
        "&body=" +
        msg.text +
        "%0A%0AFrom%2C%0A" +
        name.text;

    if (await canLaunch(url) != null) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }

    setState(() {
      topic.clear();
      msg.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    var screenwidth = MediaQuery.of(context).size.width;
    var screenheight = MediaQuery.of(context).size.height;
    name.text = EcommerceApp.sharedPreferences.getString(EcommerceApp.userName)!;
    email.text =
        EcommerceApp.sharedPreferences.getString(EcommerceApp.userEmail)!;
    return Scaffold(
      appBar: AppBar(
        // automaticallyImplyLeading: false,
        title: Text("Contact Us",
            style: TextStyle(
              color: valhalla,
            )),
        iconTheme: IconThemeData(color: Colors.black),
        flexibleSpace: Container(
          decoration: new BoxDecoration(color: carrotOrange),
        ),
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
      body: SingleChildScrollView(
        child: Container(
          decoration: BoxDecoration(),
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              children: [
                Container(
                  width: screenwidth,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  padding: EdgeInsets.all(8.0),
                  margin: EdgeInsets.all(10.0),
                  child: TextField(
                    readOnly: true,
                    controller: name,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: "Your Name",
                        hintText: "name"),
                  ),
                ),
                Container(
                  width: screenwidth,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  padding: EdgeInsets.all(8.0),
                  margin: EdgeInsets.all(10.0),
                  child: TextField(
                    readOnly: true,
                    controller: email,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: "Your Email",
                        hintText:"Email"),
                  ),
                ),
                Container(
                  width: screenwidth,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  padding: EdgeInsets.all(8.0),
                  margin: EdgeInsets.all(10.0),
                  child: TextField(
                    controller: topic,
                    maxLines: null,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText:
                           "Topic for contacting",
                        hintText: "Enter Your Topic"),
                  ),
                ),
                Container(
                  width: screenwidth,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  padding: EdgeInsets.all(8.0),
                  margin: EdgeInsets.all(10.0),
                  child: TextField(
                    controller: msg,
                    maxLines: null,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: "Your message",
                        hintText: "Your message"),
                  ),
                ),
                Container(
                  width: screenwidth - 100.0,
                  height: 50.0,
                  decoration: BoxDecoration(
                    color: tyrianPurple,
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  padding: EdgeInsets.all(8.0),
                  margin: EdgeInsets.all(10.0),
                  child: TextButton(
                    onPressed: () {
                      msg.text.isNotEmpty && topic.text.isNotEmpty
                          ? sendmsg()
                          : ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text("Please Write Some Message"),
                            ));
                    },
                    child: Text(
                      "Send Mail",
                      style: TextStyle(
                          color: white,
                          fontSize: 15.0,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                Container(
                  width: screenwidth - 50.0,
                  height: 5.0,
                  padding: EdgeInsets.all(8.0),
                  margin: EdgeInsets.all(10.0),
                  decoration: BoxDecoration(
                    color: tyrianPurple,
                  ),
                ),
                Container(
                  width: screenwidth,
                  padding: EdgeInsets.all(8.0),
                  margin: EdgeInsets.all(10.0),
                  decoration:
                      BoxDecoration(border: Border.all(color: valhalla)),
                  child: Column(
                    children: [
                      Center(
                          child: Text(
                        "You can call us here",
                        style: TextStyle(fontSize: 18.0, color: valhalla),
                      )),
                      Container(
                        width: screenwidth - 100.0,
                        height: 50.0,
                        decoration: BoxDecoration(
                          color: tyrianPurple,
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        padding: EdgeInsets.all(8.0),
                        margin: EdgeInsets.all(10.0),
                        child: TextButton(
                          onPressed: () async {
                            var url = 'tel:+446351659433';
                            if (await canLaunch(url) != null) {
                              await launch(url);
                            } else {
                              throw 'Could not launch $url';
                            }
                          },
                          child: Text(
                            "Call",
                            style: TextStyle(
                                color: white,
                                fontSize: 15.0,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
