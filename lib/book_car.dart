import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class BookCar extends StatefulWidget {

  //var
  String _id; 

  String _make;
  String _model;
  String _image;
  String _description;
  int _quantity;

  

  //constructor
  BookCar(this._id);

  @override
  _BookCarState createState() => _BookCarState();
}

class _BookCarState extends State<BookCar> {

//util
  Future<bool> fetchedCar;
  String getByIdUrl = "http://172.16.107.180:9090/car/";
  String _baseImageURL = "http://172.16.107.180:9090/img/";

//GET
Future<bool> getCar() async {

  http.Response response = await http.get(Uri.parse(getByIdUrl + widget._id));
  Map<String, dynamic> carObject = json.decode(response.body);

  widget._make = carObject["make"];
  widget._model = carObject["model"];
  widget._description = carObject["description"];
  widget._image = _baseImageURL + carObject["image"];
  widget._quantity = carObject["quantity"];

  return true;
}

  @override
    void initState() {
      // TODO: implement initState
      super.initState();
      fetchedCar = getCar();
    }


  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text("Car Booking"),
      ),
      body: FutureBuilder(
        future: fetchedCar,
        builder: (context, snapshot) {
        if(snapshot.hasData){
          return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.network(this.widget._image),
          SizedBox(
            height: 10,
          ),

          Text("Model :" + this.widget._make + " " + this.widget._model),
          SizedBox(
            height: 10,
          ),

          Text("Description : "),
          Text(this.widget._description),
          SizedBox(
            height: 10,
          ),

          Text("Quantity : " + this.widget._quantity.toString()),
          SizedBox(
            height: 10,
          ),

          Center(
            child: FlatButton(
              child: Text("Book this Car"),
              onPressed: () {
                  http.patch(Uri.parse(getByIdUrl + widget._id)).then((http.Response response){
                    http.get(Uri.parse(getByIdUrl + widget._id)).then((http.Response res){
                      setState(() {
                        widget._quantity = json.decode(res.body)["quantity"];
                      });
                    });
                  });
              },
              ),
          )

      ],);
        } else{
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        },
        )
    );
  }
}