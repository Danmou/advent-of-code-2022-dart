import "dart:io";
import 'dart:math';


class Point {
  final int x;
  final int y;

  const Point(this.x, this.y);

  Point operator +(Point other) {
    return Point(x + other.x, y + other.y);
  }

  @override
  String toString() {
    return "($x, $y)";
  }
}

void main(List<String> arguments) {
  var content = File("bin/day14/input.txt").readAsStringSync().trim();
  var rockLines = <List<Point>>[];
  var minX = 500;
  var maxX = 500;
  var minY = 0;
  var maxY = 0;
  for (var line in content.split("\n")) {
    var rockLine = <Point>[];
    for (var point in line.split(" -> ")) {
      var parts = point.split(",");
      var x = int.parse(parts[0]);
      var y = int.parse(parts[1]);
      rockLine.add(Point(x, y));
      minX = min(minX, x);
      maxX = max(maxX, x);
      minY = min(minY, y);
      maxY = max(maxY, y);
    }
    rockLines.add(rockLine);
  }
  minX--;
  maxX++;

  var width = maxX - minX + 1;
  var height = maxY - minY + 1;
  var map = List.generate(height, (_) => List.filled(width, "."));
  for (var rockLine in rockLines) {
    for (var i = 0; i < rockLine.length - 1; i++) {
      var start = rockLine[i];
      var end = rockLine[i + 1];
      var x = min(start.x, end.x) - minX;
      var y = min(start.y, end.y) - minY;
      var dx = (end.x - start.x).abs();
      var dy = (end.y - start.y).abs();
      if (dx == 0) {
        for (var j = 0; j <= dy; j++) {
          map[y + j][x] = "#";
        }
      } else {
        for (var j = 0; j <= dx; j++) {
          map[y][x + j] = "#";
        }
      }
    }
  }

  var numSandAtRest = 0;

  sandSpawnLoop:
  while (true) {
    var sandLocation = Point(500 - minX, 0 - minY);
    gravityLoop:
    while (true) {
      for (var direction in [Point(0, 1), Point(-1, 1), Point(1, 1)]) {
        var next = sandLocation + direction;
        if (next.y >= height) {
          break sandSpawnLoop;
        }
        if (map[next.y][next.x] == ".") {
          sandLocation = next;
          continue gravityLoop;
        }
      }
      map[sandLocation.y][sandLocation.x] = "o";
      numSandAtRest++;
      break gravityLoop;
    }
  }

  for (var l in map) {
    print(l.join());
  }

  print(numSandAtRest);
}
