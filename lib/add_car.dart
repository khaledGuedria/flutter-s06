import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class AddCar extends StatefulWidget {
//constructor
  AddCar();

  @override
  _AddCarState createState() => _AddCarState();
}

class _AddCarState extends State<AddCar> {

  //var
  String _make;
  String _model;
  String _description;
  int _quantity;

  final GlobalKey<FormState> _globalKey = new GlobalKey();

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Form(
          key: _globalKey,
          child: ListView(
          children: [
            Image.asset("Assets/car-shadow.png"),
            SizedBox(
              height: 10,
            ),
            TextFormField(
              decoration: InputDecoration(
                  border: OutlineInputBorder(), labelText: "Make"),
              validator: (value) {
                    if(value.isEmpty)
                      return "Make cannot be empty!";
                  },
              onSaved: (newValue) {
                _make = newValue;
              },
              
            ),
            SizedBox(
              height: 10,
            ),
            TextFormField(
              decoration: InputDecoration(
                  border: OutlineInputBorder(), labelText: "Model"),
                  validator: (value) {
                    if(value.isEmpty)
                      return "Model cannot be empty!";
                  },
              onSaved: (newValue) {
                _model = newValue;
              },
            ),
            SizedBox(
              height: 10,
            ),
            TextFormField(
              maxLines: 4,
              decoration: InputDecoration(
                  border: OutlineInputBorder(), labelText: "Description"),
              validator: (value) {
                    if(value.isEmpty)
                      return "Description cannot be empty!";
                  },
                  
              onSaved: (newValue) {
                _description = newValue;
              },
            ),
            SizedBox(
              height: 10,
            ),
            TextFormField(
              decoration: InputDecoration(
                  border: OutlineInputBorder(), labelText: "Quantity"),
                  validator: (value) {
                    if(value.isEmpty)
                      return "Quantity cannot be empty!";
                  },
                  onSaved: (khaled) {
                    _quantity = int.parse(khaled);
                  },
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                RaisedButton(
                  child: Text("Add"),
                  onPressed: () {

                    //validator call
                    if(!_globalKey.currentState.validate())
                    return;
                    //get attributes
                  _globalKey.currentState.save();

                  //ADD CAR MATHOD
                  //url
                  String addURL = "http://172.16.107.180:9090/car";

                  //HEADERS
                  Map<String, String> headers = {
                      "Content-Type" : "application/json; chartset=UTF-8"
                  };

                  //OBJECT
                  Map<String, dynamic> carObject = {
                    
                    "make" : _make,
                    "model" : _model,
                    "description" : _description,
                    "quantity" : _quantity

                  };

                  //POST METHOD
                  http.post(Uri.parse(addURL), headers: headers, body: json.encode(carObject)).then((http.Response response){
                    var message = response.statusCode == 201 ? "Car added successfully." : "Something wrong !";
                    showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                    title: Text("Car Confirmation"),
                    content: Text(message),
                  );
                  },);
                  });

                  //popup
                  /*showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                    title: Text("Car Information"),
                    content: Text("Make : "+ _make + "\n Model : " + _model + "\n Description : " + _description + "\n Quantity : " + _quantity.toString()),
                  );
                  },);*/

                  },
                ),
                RaisedButton(
                  child: Text("Cancel"),
                  onPressed: () {
                    _globalKey.currentState.reset();
                  },
                ),
              ],
            )
          ],
        ),
      );
  }
}
