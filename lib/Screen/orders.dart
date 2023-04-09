import 'package:flutter/material.dart';
import '/Screen/menueditor.dart';
import '/Screen/orders/completed.dart';
import '/Screen/orders/incoming.dart';
import '/Screen/orders/preparing.dart';
import '/Screen/profile.dart';
import 'package:contained_tab_bar_view/contained_tab_bar_view.dart';
import '/Widgets/color.dart';


class Orders extends StatefulWidget {
  @override
  _OrdersState createState() => _OrdersState();
}

class _OrdersState extends State<Orders> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: ContainedTabBarView(
        tabs: [
          Tab(
            icon: Icon(Icons.menu_open),
            text: "Incoming",
          ),
          Tab(
            icon: Icon(Icons.restaurant),
            text: "Preparing",
          ),
          Tab(
            icon: Icon(Icons.local_restaurant),
            text: "Completed",
          ),
        ],
        tabBarProperties: TabBarProperties(
          height: 70.0,
          background: Container(
            decoration: BoxDecoration(color: carrotOrange),
          ),
          indicatorColor: valhalla,
          indicatorWeight: 6.0,
          labelColor: valhalla,
          unselectedLabelColor: solitude,
        ),
        views: [ Incoming(),  Preparing(), Completed()],
        onChange: (index) => print(index),
      ),
    );
  }
}
