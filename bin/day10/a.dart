import "dart:io";
import "dart:math";


void main(List<String> arguments) {
  var content = File("bin/day10/input.txt").readAsStringSync().trim();
  var cycle = 0;
  var x = 1;
  var sum = 0;
  for (var line in content.split("\n")) {
    int cycles;
    int dx;
    if (line == "noop") {
      cycles = 1;
      dx = 0;
    } else if (line.startsWith("addx")) {
      cycles = 2;
      dx = int.parse(line.split(" ")[1]);
    } else {
      throw "Unknown line: $line";
    }
    var nextCycle = cycle + cycles;
    for (var cycleOfInterest in [20, 60, 100, 140, 180, 220]) {
      if (cycleOfInterest > cycle && cycleOfInterest <= nextCycle) {
        sum += x * cycleOfInterest;
      }
    }
    x += dx;
    cycle = nextCycle;
    if (cycle >= 220) {
      break;
    }
  }
  print(sum);
}
