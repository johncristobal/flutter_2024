void main() async {
  print("inicio");

  try {
    final value = await httpGet("url");
    print(value);
  } on Exception catch(err) {
    print("Excepcion... $err");
  } catch (err){
    print(err);
  } finally {
    print("fin try catch");
  }

  print("fin");
}

Future<String> httpGet(String url) async {
  await Future.delayed(Duration(milliseconds: 1000));
  // return "Respuesta http";
  throw Exception("No hay params en url");
}