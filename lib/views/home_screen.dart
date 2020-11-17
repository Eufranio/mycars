import 'package:flutter/material.dart';
import 'package:mycars/models/car.dart';
import 'package:mycars/repository/car_repository.dart';
import 'package:mycars/widgets/search_list.dart';
import 'package:mycars/widgets/user_info_drawer.dart';

class HomeScreen extends StatelessWidget {

  final CarRepository repository = CarRepository();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: UserInfoDrawer(),
      appBar: AppBar(
        title: Text('MyCars'),
      ),
      body: Container(
        child: Center(
          child: SearchList<Car>(
            stream: (_) => repository.cars(),
            buildItem:  _buildCar,
          )
        ),
      ),
    );
  }

  Widget _buildCar(Car car) => Padding(
    padding: EdgeInsets.only(left: 15, right: 15, bottom: 15),
    child: Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Padding(
        padding: EdgeInsets.all(15),
        child: Row(
          children: [
            Padding(
              padding: EdgeInsets.only(right: 15),
              child: Icon(Icons.directions_car_outlined, size: 40, color: Colors.deepPurple[800],),
            ),
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Text('${car.marca} ${car.modelo} ${car.anoModelo}',
                    style: TextStyle(fontSize: 18, color: Colors.orange, fontWeight: FontWeight.bold),),
                  Text('Fabricação: ${car.anoFabricacao}', style: TextStyle(color: Colors.black54)),
                  Text('Placa: ${car.placa}', style: TextStyle(color: Colors.black54))
                ],
              ),
            ),
          ],
        ),
      ),
    ),
  );
}