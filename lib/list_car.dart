import 'package:flutter/material.dart';
import 'package:my_app/book_car.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ListCar extends StatefulWidget{
  //var
  String fetchAllURL = "http://172.16.107.180:9090/car";
  String _baseImageURL = "http://172.16.107.180:9090/img/";

  //constructor
  ListCar();


  
  @override
  _ListCarState createState() => _ListCarState();
}



class _ListCarState extends State<ListCar> {

  //var
  List<CarView> cars = [
          //CarView("BMW"," Serie 3","Assets/bmw-serie3.jpg","Manhart V8 5.5L ", 33),
          //CarView("Cherry","Tiggo 7","Assets/chery-tiggo7.jpg", "Rabbi yba9i esseter!", 128),
          //CarView("KIA","Sportage","Assets/kia-sportage.jpg", "A.K.A 4x4", 81),
          //CarView("Peugeot","208","Assets/peugeot-208.jpg", "GTI 278 cv STAGE 1 ", 56),
        ];

  Future<bool> fetchedCar;

  Future<bool> fetchCar() async {

    http.Response response = await http.get(Uri.parse(widget.fetchAllURL));
    List<dynamic> carsFromServer = json.decode(response.body);

    for (var item in carsFromServer) {
      cars.add(CarView(item["_id"], item["make"], item["model"], widget._baseImageURL + item["image"]));
    }

    return true;
  }
  

  



  @override
    void initState() {
      // TODO: implement initState
      super.initState();

      fetchedCar = fetchCar();

    }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return FutureBuilder(
      future: fetchedCar,
      builder: (context, snapshot) {
        if(snapshot.hasData){
          return ListView.builder (
          itemBuilder: (BuildContext context, int index) {
          return cars[index];
          },
          itemCount: cars.length,
          );
        } else{
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}

class CarView extends StatelessWidget {
  
  //var
  String _id;
  String _make;
  String _model;
  String _image;
  //String _description;
  //int _quantity;

  CarView(this._id, this._make, this._model, this._image);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return InkWell(
        onTap: () {
          //Navigator.pushNamed(context, "/add");
          Navigator.push(context, MaterialPageRoute(
            builder: (BuildContext context) {
              return BookCar(_id);
            },
            ));
        },
        child: Card (
        child: Row (
          children: [
            Image.network(this._image, width: 120,),
            Container(
                child: Column(
                children: [
                    Text(this._make),
                    Text(this._model),
              ],
              ),
            margin: EdgeInsets.fromLTRB(50, 0, 0, 0),
            )


        ],
        ),
        ),
    );
  }

}