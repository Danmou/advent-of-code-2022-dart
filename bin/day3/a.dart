import "dart:io";

void main(List<String> arguments) {
  var content = File("bin/day3/input.txt").readAsStringSync();
  var total = 0;
  for (var bagContent in content.trim().split("\n")) {
    var compartmentSize = bagContent.length ~/ 2;
    assert(compartmentSize * 2 == bagContent.length);
    var left = bagContent.substring(0, compartmentSize).split("").toSet();
    var right = bagContent.substring(compartmentSize).split("").toSet();
    var intersection = left.intersection(right);
    assert(intersection.length == 1);
    total += itemPriority(intersection.first);
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
