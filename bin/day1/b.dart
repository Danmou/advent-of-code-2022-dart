import "dart:io";
import "dart:math";

void main(List<String> arguments) {
  var content = File("bin/day1/input.txt").readAsStringSync();
  var calsPerElf = content.trim().split("\n\n").map((chunk) => chunk
      .split("\n")
      .map((line) => int.parse(line))
      .fold(0, (a, b) => a + b)
      ).toList();
  calsPerElf.sort();
  var sumTop3Cals = calsPerElf.reversed.take(3).fold(0, (a, b) => a + b);
  print(sumTop3Cals);
}
