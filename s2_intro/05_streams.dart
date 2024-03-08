void main() {
  emitNumbers().listen((value) {
    print(value);
  });
}

Stream<int> emitNumbers() async* {
  final values = [1,2,3,4,5];
  for(int i in values) {
    await Future.delayed(Duration(seconds: 1));
    yield i;
  }
}
