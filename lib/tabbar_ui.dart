import 'package:flutter/material.dart';
import 'package:my_app/add_car.dart';
import 'package:my_app/list_car.dart';

class TabBarWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2, 
      child: Scaffold(
        appBar: AppBar(
          title: Text("Menu with Tabs"),
          bottom: TabBar(tabs: [
            Tab(
              text: "List Car",
              icon: Icon(Icons.list),
            ),
            Tab(
              text : "Add Car",
              icon: Icon(Icons.edit),
            )
          ]),
        ),
        drawer: Drawer(
          child: Scaffold(
            appBar: AppBar(
            automaticallyImplyLeading: false,
            title: Text("Choose an option"),
          ),
          body: ListTile(
            title: Text("Go to Bottom nav GUI"),
            onTap: () {
              Navigator.pushReplacementNamed(context, "/bottom");
            },
          )
          )
          ),
        body: TabBarView(children: [
          ListCar(),
          AddCar()
        ]),
      ));
  }
}