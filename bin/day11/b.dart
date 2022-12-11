import "dart:io";

class Monkey {
  final List<int> _items;
  final int Function(int old) _updateItem;
  final int _decisionNumber;
  final int _trueRecipient;
  final int _falseRecipient;
  int numInspected = 0;
  late int maxFactor;

  Monkey(List<int> items, this._updateItem, this._decisionNumber,
      this._trueRecipient, this._falseRecipient)
      : _items = items.map((e) => e).toList(growable: true);

  void give(int value) {
    _items.add(value);
  }

  void process(List<Monkey> monkeys) {
    while (_items.isNotEmpty) {
      numInspected++;
      var value = _items.removeAt(0);
      value = _updateItem(value);
      value %= maxFactor;
      var recipient =
          (value % _decisionNumber == 0) ? _trueRecipient : _falseRecipient;
      monkeys[recipient].give(value);
    }
  }
}

void main(List<String> arguments) {
  // var monkeys = [
  //   Monkey([79, 98], (old) => old * 19, 23, 2, 3),
  //   Monkey([54, 65, 75, 74], (old) => old + 6, 19, 2, 0),
  //   Monkey([79, 60, 97], (old) => old * old, 13, 1, 3),
  //   Monkey([74], (old) => old + 3, 17, 0, 1),
  // ];
  var monkeys = [
    Monkey(
        [83, 97, 95, 67],
        (old) => old * 19,
        17, 2, 7),
    Monkey(
        [71, 70, 79, 88, 56, 70],
        (old) => old + 2,
        19, 7, 0),
    Monkey(
        [98, 51, 51, 63, 80, 85, 84, 95],
        (old) => old + 7,
        7, 4, 3),
    Monkey(
        [77, 90, 82, 80, 79],
        (old) => old + 1,
        11, 6, 4),
    Monkey(
        [68],
        (old) => old * 5,
        13, 6, 5),
    Monkey(
        [60, 94],
        (old) => old + 5,
        3, 1, 0),
    Monkey(
        [81, 51, 85],
        (old) => old * old,
        5, 5, 1),
    Monkey(
        [98, 81, 63, 65, 84, 71, 84],
        (old) => old + 3,
        2, 2, 3),
  ];

  int maxFactor = monkeys
      .map((e) => e._decisionNumber)
      .reduce((value, element) => value * element);
  for (var element in monkeys) {
    element.maxFactor = maxFactor;
  }

  for (var round = 0; round < 10000; round++) {
    for (var monkey in monkeys) {
      monkey.process(monkeys);
    }
    if (round == 0 || round == 19 || (round + 1) % 1000 == 0) {
      print("\nRound ${round + 1}:");
      for (var i = 0; i < monkeys.length; i++) {
        print("Monkey $i: ${monkeys[i].numInspected}");
      }
    }
  }

  var numInspected = monkeys.map((m) => m.numInspected).toList();
  numInspected.sort();
  print(numInspected[numInspected.length - 2] * numInspected.last);
}
