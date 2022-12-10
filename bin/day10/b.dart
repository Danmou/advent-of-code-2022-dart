import "dart:io";
import "dart:math";


void main(List<String> arguments) {
  var content = File("bin/day10/input.txt").readAsStringSync().trim();
  var cycle = 0;
  var x = 1;
  var screen = "";
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
    for (var i = 0; i < cycles; i++) {
      if (cycle >= x - 1 && cycle <= x + 1) {
        screen += "#";
      } else {
        screen += ".";
      }
      if (cycle == 39) {
        print(screen);
        cycle = 0;
        screen = "";
      } else {
        cycle++;
      }
    }
    x += dx;
  }
}
