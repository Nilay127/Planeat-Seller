// TODO Implement this library.import 'package:flutter/material.dart';
import 'login.dart';
import 'register.dart';
import 'package:flutter/material.dart';

import '../Widgets/color.dart';
import '../Config/config.dart';


class AuthenticScreen extends StatefulWidget {
  @override
  _AuthenticScreenState createState() => _AuthenticScreenState();
}

class _AuthenticScreenState extends State<AuthenticScreen> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: false,
            flexibleSpace: Container(
              decoration: new BoxDecoration(color: carrotOrange),
            ),
            title: Column(
              children: [
                SizedBox(
                  height: 10.0,
                ),
                Text(
                  "Seller PlanEat",
                  style: TextStyle(
                    fontSize: 40.0,
                    color: valhalla,
                  ),
                ),
              ],
            ),
            centerTitle: true,
            bottom: TabBar(
              tabs: [
                Tab(
                  child: Text(
                    "Login",
                    style: TextStyle(color: valhalla),
                  ),
                  icon: Icon(
                    Icons.lock,
                    color: valhalla,
                  ),
                  // text: "Login",
                ),
                Tab(
                  child: Text(
                    "Register",
                    style: TextStyle(color: valhalla),
                  ),
                  icon: Icon(
                    Icons.person,
                    color: valhalla,
                  ),
                  // text: "Register",
                )
              ],
              indicatorColor: valhalla,
              indicatorWeight: 5.0,
            ),
          ),
          body: Container(
            decoration: new BoxDecoration(color: solitude),
            child: TabBarView(
              children: [
                Login(),
                Register(),
              ],
            ),
          ),
        ));
  }
}
