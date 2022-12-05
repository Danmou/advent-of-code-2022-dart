import "dart:io";
import "dart:math";

void main(List<String> arguments) {
  var content = File("bin/day1/input.txt").readAsStringSync();
  var maxCal = content.trim().split("\n\n").map((chunk) => chunk
      .split("\n")
      .map((line) => int.parse(line))
      .fold(0, (a, b) => a + b)
      )
  .reduce(max);
  print(maxCal);
}
