class Car {

  String id, anoFabricacao, anoModelo, modelo, marca, placa;

  Car([this.anoFabricacao, this.anoModelo, this.modelo, this.marca, this.placa]);

  Car.fromMap(String id, Map snapshot) :
        id = id,
        anoFabricacao = snapshot['anoFabricacao'],
        anoModelo = snapshot['anoModelo'],
        modelo = snapshot['modelo'],
        marca = snapshot['marca'],
        placa = snapshot['placa'];

  toJson() => {
    'anoFabricacao': anoFabricacao,
    'anoModelo': anoModelo,
    'modelo': modelo,
    'marca': marca,
    'placa': placa
  };

  static Car empty = Car();

}