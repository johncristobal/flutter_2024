void main() {

  final wolverie = Hero(name: "logan", power: "cuchillos");
  print(wolverie);

  //final spoider = Hero.fromJson(json);
}

class Hero {
  String name;
  String power;

  Hero({ 
    required this.name,
    this.power = "Sin poder"
  }) : assert(name.length > 3);

  Hero.fromJson(Map<String, dynamic> json) 
    : name = json["name"] ?? "Nop", 
    power = json["power"] ?? "Nop 2";

  @override
  String toString() {
    return "Hola super";
  }

  String? _side;
  set side(String value) {
    _side = value;
  }
  String get area {
    return _side!;
  }
  // Hero(String name, String power) {
  //   this.name = name;
  //   this.power = power;
  // }
}

enum TypeP {
  nuclear, wind, water
}
abstract class EnergyPlant { 
  double left;
  TypeP type;

  EnergyPlant({
    required this.left,
    required this.type
  });

  void consume( double amount ); 
}

class OnePlant extends EnergyPlant {
  
  OnePlant({required double left, required TypeP ttt})
  : super(left: left, type: ttt);

  @override
  void consume(double amount) {

  }
}

class TwoPlant implements EnergyPlant {
  double left;
  final TypeP type = TypeP.nuclear;

  TwoPlant({
    required this.left
  });

  @override
  void consume(double amount) {

  }
  
  @override
  set type(TypeP _type) {
    // TODO: implement type
  }

}
