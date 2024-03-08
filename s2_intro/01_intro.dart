void main() {
  final name = "Alex";
  final hp = 100;
  final alive = true;
  final abilities = [
    'impstor'
  ];

  dynamic error = "Hols";

  final pokemon = {
    "name": "hi",
    "age": 30,
    "alive": true,
    "sprites": {
      1: "a",
      2: "b"
    }
  };

  pokemon["name"];

  print("""
  String multilinea
  $name
  """);
}

void lists() {
  final numbers = [1,2,3,4,5,6,9,9];
  print(numbers.length);
  print(numbers.first);
  final reversed = numbers.reversed;

  reversed.toList();
  reversed.toSet();

  numbers.where((element) => element > 5);
}

String functionName () {
  return "hi";
}

String functionTwo() => "Hi 2";

int addTwoNumbers(int a, int b) => a+b;

int addTwoNumbersOptional(int a, [int? b]){
  b ??= 0;
  return a+b;
} 

int addTwoNumbersOptionalT(int a, [int b = 0]){
  return a+b;
} 

String greet({ required String name, String message = "Hola" }) {
  return "Hola";
}