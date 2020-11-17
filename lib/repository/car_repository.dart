import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mycars/models/car.dart';

class CarRepository {

  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final String collection = 'carros';

  Stream<List<Car>> cars() {
    return firestore.collection(collection).snapshots().map((snapshot) {
      return snapshot.docs.map((doc) => Car.fromMap(doc.id, doc.data())).toList();
    });
  }

}