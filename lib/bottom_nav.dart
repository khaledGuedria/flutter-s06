import 'package:flutter/material.dart';
import 'package:my_app/add_car.dart';
import 'package:my_app/list_car.dart';

class BottomNavigation extends StatefulWidget {
  @override
  _BottomNavigationState createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigation> {
  //var
    int _bottomIndex = 0;
    List<Widget> interfaces = [ListCar(), AddCar()];

  @override
  Widget build(BuildContext context) {
    
    
    return Scaffold(
      appBar: AppBar(
        title: Text("Menu with Bottom Nav"),
      ),
      drawer: Drawer(
        child: Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: false,
            title: Text("Choose an option"),
          ),
          body: ListTile(
            title: Text("Go to Menu to Top Bar GUI"),
            onTap: () {
              Navigator.pushNamed(context, "/");
            },
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: [
        BottomNavigationBarItem(
          label: "List Car",
          icon: Icon(Icons.list),
          ),
        BottomNavigationBarItem(
          label: "Add new Car",
          icon: Icon(Icons.edit)
          ),
      ],
      currentIndex: _bottomIndex,
      onTap: (int value){
        setState(() {
          _bottomIndex = value;
        });
      },
      ),
      body: interfaces[_bottomIndex],
      );
  }
}