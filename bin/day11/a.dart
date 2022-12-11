import "dart:io";

class Monkey {
  List<BigInt> _items;
  BigInt Function(BigInt old) _updateItem;
  int Function(BigInt value) _getRecipient;
  BigInt numInspected = BigInt.zero;

  Monkey(List<int> items, this._updateItem, this._getRecipient)
      : _items = items.map((e) => BigInt.from(e)).toList(growable: true);

  void give(BigInt value) {
    _items.add(value);
  }

  void process(List<Monkey> monkeys) {
    while (_items.isNotEmpty) {
      numInspected += BigInt.one;
      var value = _items.removeAt(0);
      // print("  Monkey inspects an item with a worry level of $value.");
      value = _updateItem(value);
      // print("    Worry level is updated to $value.");
      value ~/= BigInt.from(3);
      // print("    Worry level is divided by 3 to $value.");
      var recipient = _getRecipient(value);
      // print("    Item with worry level $value is thrown to monkey $recipient.");
      monkeys[recipient].give(value);
    }
  }
}

void main(List<String> arguments) {
  // var monkeys = [
  //   Monkey([79, 98], (old) => old * BigInt.from(19),
  //       (value) => (value % BigInt.from(23) == BigInt.from(0)) ? 2 : 3),
  //   Monkey([54, 65, 75, 74], (old) => old + BigInt.from(6),
  //       (value) => (value % BigInt.from(19) == BigInt.from(0)) ? 2 : 0),
  //   Monkey([79, 60, 97], (old) => old * old,
  //       (value) => (value % BigInt.from(13) == BigInt.from(0)) ? 1 : 3),
  //   Monkey([74], (old) => old + BigInt.from(3),
  //       (value) => (value % BigInt.from(17) == BigInt.from(0)) ? 0 : 1),
  // ];
  var monkeys = [
    Monkey(
        [83, 97, 95, 67],
        (old) => old * BigInt.from(19),
        (value) => (value % BigInt.from(17) == BigInt.from(0)) ? 2 : 7),
    Monkey(
        [71, 70, 79, 88, 56, 70],
        (old) => old + BigInt.from(2),
        (value) => (value % BigInt.from(19) == BigInt.from(0)) ? 7 : 0),
    Monkey(
        [98, 51, 51, 63, 80, 85, 84, 95],
        (old) => old + BigInt.from(7),
        (value) => (value % BigInt.from(7) == BigInt.from(0)) ? 4 : 3),
    Monkey(
        [77, 90, 82, 80, 79],
        (old) => old + BigInt.from(1),
        (value) => (value % BigInt.from(11) == BigInt.from(0)) ? 6 : 4),
    Monkey(
        [68],
        (old) => old * BigInt.from(5),
        (value) => (value % BigInt.from(13) == BigInt.from(0)) ? 6 : 5),
    Monkey(
        [60, 94],
        (old) => old + BigInt.from(5),
        (value) => (value % BigInt.from(3) == BigInt.from(0)) ? 1 : 0),
    Monkey(
        [81, 51, 85],
        (old) => old * old,
        (value) => (value % BigInt.from(5) == BigInt.from(0)) ? 5 : 1),
    Monkey(
        [98, 81, 63, 65, 84, 71, 84],
        (old) => old + BigInt.from(3),
        (value) => (value % BigInt.from(2) == BigInt.from(0)) ? 2 : 3),
  ];

  for (var round = 0; round < 20; round++) {
    for (var monkey in monkeys) {
      monkey.process(monkeys);
    }
    print("\nRound $round:");
    for (var i = 0; i < monkeys.length; i++) {
      print("Monkey $i: ${monkeys[i]._items}");
    }
  }

  var numInspected = monkeys.map((m) => m.numInspected).toList();
  numInspected.sort();
  print(numInspected);
  print(numInspected[numInspected.length - 2] * numInspected.last);
}
