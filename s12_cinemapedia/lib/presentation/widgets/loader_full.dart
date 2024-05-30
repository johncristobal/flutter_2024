import 'package:flutter/material.dart';

class FullLoader extends StatelessWidget {

  final messages = <String>[
    "Cargando pelis",
    "Comprando",
    "Cargando populares",
    "Ya mero",
    "Tarda mucho :(",
  ];

  FullLoader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text("Waiting..."),
          const SizedBox( height: 10,),
          const CircularProgressIndicator(strokeWidth: 2,),
          const SizedBox( height: 10,),
          StreamBuilder(
            stream: Stream.periodic(const Duration(milliseconds: 1200), (step) {
                return messages[step];
            }).take(messages.length), 
            builder: (context, snapshot) {
              if(!snapshot.hasData) return const Text("Loading...");
              return Text(snapshot.data!);
            },)
        ],
      ),
    );
  }
}