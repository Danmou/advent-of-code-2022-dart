import "dart:io";

void main(List<String> arguments) {
  var content = File("bin/day3/input.txt").readAsStringSync();
  var lines = content.trim().split("\n").toList();
  var total = 0;
  for (var i = 0; i < lines.length; i += 3) {
    var contents = lines.sublist(i, i + 3).map((line) => line.split("").toSet()).toList();
    var common = contents.reduce((a, b) => a.intersection(b));
    assert(common.length == 1);
    total += itemPriority(common.first);
  }
  print(total);
}

int itemPriority(String item) {
  assert(item.length == 1);
  var lowerA = "a".codeUnitAt(0);
  var lowerZ = "z".codeUnitAt(0);
  var upperA = "A".codeUnitAt(0);
  var upperZ = "Z".codeUnitAt(0);
  var code = item.codeUnitAt(0);
  assert(lowerA <= code && code <= lowerZ || upperA <= code && code <= upperZ);
  if (lowerA <= code && code <= lowerZ) {
    return code - lowerA + 1;
  } else {
    return code - upperA + 27;
  }
}
