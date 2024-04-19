import 'package:flutter/material.dart';

class UIControlsScreen extends StatelessWidget {
  const UIControlsScreen({Key? key}) : super(key: key);
  static const name = "ui_screen";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("UI Controls"),
      ),
      body: const _UIControlsView(),
    );
  }
}

enum Transportation { car, plane, boat, submarine }

class _UIControlsView extends StatefulWidget {
  const _UIControlsView({
    super.key,
  });

  @override
  State<_UIControlsView> createState() => _UIControlsViewState();
}

class _UIControlsViewState extends State<_UIControlsView> {
  bool isDev = true;
  Transportation transportation = Transportation.car;

  bool breakfastOn = false;
  bool lunchtOn = false;
  bool dinnerOn = false;

  @override
  Widget build(BuildContext context) {
    return ListView(
      physics: const ClampingScrollPhysics(),
      children: [
        SwitchListTile(
            title: const Text("Developer mode"),
            subtitle: const Text("Control"),
            value: isDev,
            onChanged: (value) {
              setState(() {
                isDev = !isDev;
              });
            }),
        ExpansionTile(
          title: Text("Vehiculo de transporte"),
          subtitle: Text(transportation.name),
          children: [
            RadioListTile(
                title: const Text("Car"),
                value: Transportation.car,
                groupValue: transportation,
                onChanged: (value) {
                  setState(() {
                    transportation = Transportation.car;
                  });
                }),
            RadioListTile(
                title: const Text("Bote"),
                value: Transportation.boat,
                groupValue: transportation,
                onChanged: (value) {
                  setState(() {
                    transportation = Transportation.boat;
                  });
                }),
            RadioListTile(
                title: const Text("Avion"),
                value: Transportation.plane,
                groupValue: transportation,
                onChanged: (value) {
                  setState(() {
                    transportation = Transportation.plane;
                  });
                }),
            RadioListTile(
                title: const Text("Submarino"),
                value: Transportation.submarine,
                groupValue: transportation,
                onChanged: (value) {
                  setState(() {
                    transportation = Transportation.submarine;
                  });
                })
          ],
        ),

        CheckboxListTile(
          title: Text("Desayuno?"),
          value: breakfastOn, 
          onChanged: (value){ setState(() { breakfastOn = !breakfastOn; }); }
        ),
        CheckboxListTile(
          title: Text("Comida?"),
          value: lunchtOn, 
          onChanged: (value){ setState(() { lunchtOn = !lunchtOn; }); }
        ),
        CheckboxListTile(
          title: Text("Cena?"),
          value: dinnerOn, 
          onChanged: (value){ setState(() { dinnerOn = !dinnerOn; }); }
        ),
      ],
    );
  }
}
