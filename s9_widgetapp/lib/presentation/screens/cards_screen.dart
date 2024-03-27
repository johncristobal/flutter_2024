import 'package:flutter/material.dart';

class CardsScreen extends StatelessWidget {
  const CardsScreen({Key? key}) : super(key: key);
  static const name = "cards_screen";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Cards"),
      ),
      body: const _CardsView(),
    );
  }
}

class _CardsView extends StatelessWidget {
  const _CardsView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          ...cards.map(
            (card) => _CardType1(elevation: card["elevation"], label: card["label"],)
          ),
          ...cards.map(
            (card) => _CardType2(elevation: card["elevation"], label: card["label"],)
          ),
          ...cards.map(
            (card) => _CardType3(elevation: card["elevation"], label: card["label"],)
          ),
          ...cards.map(
            (card) => _CardType4(elevation: card["elevation"], label: card["label"],)
          ),
          SizedBox(height: 50,)
        ],
      ),
    );
  }
}

class _CardType1 extends StatelessWidget {
  final String label;
  final double elevation;
  const _CardType1({Key? key, required this.label, required this.elevation}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: elevation,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(10, 5, 10, 10),
        child: Column(
          children: [
            Align(
              alignment: Alignment.topRight,
              child: IconButton(
                icon: Icon(Icons.more_vert),
                onPressed: (){},
              )
            ),
            Align(
              alignment: Alignment.bottomLeft,
              child: Text(label)
            ),
          ],
        ),
      ),
    );
  }
}

class _CardType2 extends StatelessWidget {
  final String label;
  final double elevation;
  const _CardType2({Key? key, required this.label, required this.elevation}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(12)),
        side: BorderSide(
          color: colors.outline
        )
      ),
      elevation: elevation,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(10, 5, 10, 10),
        child: Column(
          children: [
            Align(
              alignment: Alignment.topRight,
              child: IconButton(
                icon: Icon(Icons.more_vert),
                onPressed: (){},
              )
            ),
            Align(
              alignment: Alignment.bottomLeft,
              child: Text(label)
            ),
          ],
        ),
      ),
    );
  }
}

class _CardType3 extends StatelessWidget {
  final String label;
  final double elevation;
  const _CardType3({Key? key, required this.label, required this.elevation}) : super(key: key);

  @override
  Widget build(BuildContext context) {
     final colors = Theme.of(context).colorScheme;
    return Card(
      color: colors.surfaceVariant,
      elevation: elevation,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(10, 5, 10, 10),
        child: Column(
          children: [
            Align(
              alignment: Alignment.topRight,
              child: IconButton(
                icon: Icon(Icons.more_vert),
                onPressed: (){},
              )
            ),
            Align(
              alignment: Alignment.bottomLeft,
              child: Text(label)
            ),
          ],
        ),
      ),
    );
  }
}

class _CardType4 extends StatelessWidget {
  final String label;
  final double elevation;
  const _CardType4({Key? key, required this.label, required this.elevation}) : super(key: key);

  @override
  Widget build(BuildContext context) {
     final colors = Theme.of(context).colorScheme;
    return Card(
      clipBehavior: Clip.hardEdge,
      color: colors.surfaceVariant,
      elevation: elevation,
      child: Stack(
        children: [
          Image.network(
            "https://picsum.photos/id/${elevation.toInt()}/600/350",
            height: 350,
            fit: BoxFit.cover,
          ),
          Align(
            alignment: Alignment.topRight,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(bottomLeft: Radius.circular(20))
              ),
              child: IconButton(
                icon: Icon(Icons.more_vert),
                onPressed: (){},
              ),
            )
          ),
          
        ],
      ),
    );
  }
}

const cards = <Map<String, dynamic>> [
  {  "elevation": 0.0, "label": "Elevation 0" },
  {  "elevation": 1.0, "label": "Elevation 1" },
  {  "elevation": 2.0, "label": "Elevation 2" },
  {  "elevation": 3.0, "label": "Elevation 3" },
  {  "elevation": 4.0, "label": "Elevation 4" },
  {  "elevation": 5.0, "label": "Elevation 5" },
];