enum From {
  mine, hers
}

class Message {
  final String text;
  final String? imageUrl;
  final From from;

  Message({
    required this.text,
    this.imageUrl,
    required this.from
  });

}

