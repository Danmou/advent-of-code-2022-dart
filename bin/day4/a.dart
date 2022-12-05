import "dart:io";

void main(List<String> arguments) {
  var content = File("bin/day4/input.txt").readAsStringSync();
  var numRedundant = 0;
  for (var line in content.trim().split("\n")) {
    var assignments = line
        .split(",")
        .map((assignment) =>
            assignment.split("-").map((n) => int.parse(n)).toList())
        .toList();
    if (assignments[0][0] >= assignments[1][0] &&
            assignments[0][1] <= assignments[1][1] ||
        assignments[0][0] <= assignments[1][0] &&
            assignments[0][1] >= assignments[1][1]) {
      numRedundant++;
    }
  }
  print(numRedundant);
}
