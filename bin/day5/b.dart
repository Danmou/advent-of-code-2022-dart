import "dart:io";

void main(List<String> arguments) {
  var content = File("bin/day5/input.txt").readAsStringSync();
  var sections = content.trim().split("\n\n");
  var stacksDescription = sections[0];
  var movesDescription = sections[1];
  var stacks = parseStacks(stacksDescription);
  print(stacks);
  for (var moveDescription in movesDescription.split("\n")) {
    print(moveDescription);
    applyMove(stacks, moveDescription);
    print(stacks);
  }
  var tops = "";
  for (var i = 0; i < stacks.length; i++) {
    tops += stacks[i+ 1]!.last;
  }
  print(tops);
}

Map<int, List<String>> parseStacks(String stacksDescription) {
  var stacks = <int, List<String>>{};
  var lines = stacksDescription.split("\n");
  for (var line in lines.take(lines.length - 1)) {
    for (var i = 0; i < 10; i++) {
      var index = i * 4 + 1;
      if (line.length <= index) {
        continue;
      }
      if (line[index] == " ") {
        continue;
      }
      stacks.putIfAbsent(i + 1, () => []);
      stacks[i + 1]!.add(line[index]);
    }
  }
  for (var i in stacks.keys) {
    stacks[i] = stacks[i]!.reversed.toList();
  }
  return stacks;
}

void applyMove(Map<int, List<String>> stacks, String moveDescription) {
  var parts = moveDescription.split(" ");
  var count = int.parse(parts[1]);
  var source = int.parse(parts[3]);
  var destination = int.parse(parts[5]);
  stacks[destination]!.addAll(stacks[source]!.sublist(stacks[source]!.length - count));
  stacks[source]!.removeRange(stacks[source]!.length - count, stacks[source]!.length);
}
