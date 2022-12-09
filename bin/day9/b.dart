import "dart:io";
import 'dart:math';

class Point {
  final int x;
  final int y;

  Point(this.x, this.y);

  @override
  String toString() {
    return "($x, $y)";
  }

  @override
  int get hashCode => Object.hash(x, y);

  @override
  bool operator ==(Object other) {
    return other is Point &&
      other.x == x &&
      other.y == y;
  }

  Point move(int dx, int dy) {
    return Point(x + dx, y + dy);
  }

  int distance(Point other) {
    return max((x - other.x).abs(), (y - other.y).abs());
  }

  Point follow(Point other) {
    if (distance(other) < 2) {
      return this;
    }
    var dx = (other.x - x).sign;
    var dy = (other.y - y).sign;
    return move(dx, dy);
  }
}

void main(List<String> arguments) {
  var content = File("bin/day9/input.txt").readAsStringSync().trim();
  var rope = List.generate(10, (e) => Point(0, 0));
  var tailVisited = {rope.last};

  for (var line in content.split("\n")) {
    var direction = line.substring(0, 1);
    var distance = int.parse(line.substring(2));
    for (var i = 0; i < distance; i++) {
      switch (direction) {
        case "U":
          rope[0] = rope[0].move(0, 1);
          break;
        case "D":
          rope[0] = rope[0].move(0, -1);
          break;
        case "L":
          rope[0] = rope[0].move(-1, 0);
          break;
        case "R":
          rope[0] = rope[0].move(1, 0);
          break;
        default:
          throw "Unrecognized direction: $direction";
      }
      for (var j = 1; j < rope.length; j++) {
        rope[j] = rope[j].follow(rope[j - 1]);
      }
      tailVisited.add(rope.last);
    }
  }
  print(tailVisited.length);
}
