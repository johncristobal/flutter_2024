
abstract class Animal {

}

abstract class Mamifero extends Animal {

}

abstract class Ave extends Animal {

}

abstract class Pez extends Animal {

}

mixin class Volador {
  void volar() => print("Volar");
}

mixin class Caminante {
  void caminar() => print("Caminar");
}

mixin class Nadador {
  void nadar() => print("Nadar");
}

class Delfin extends Mamifero with Nadador {

}

class Murcielago extends Mamifero with Volador, Caminante {
  
}

void main() {
  // https://medium.com/flutter-community/dart-what-are-mixins-3a72344011f3
  final flipper = Delfin();
  flipper.nadar();

  final bat = Murcielago();
  bat.caminar();
  bat.volar();
}