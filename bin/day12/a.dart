import "dart:io";


class Point {
  final int x;
  final int y;

  const Point(this.x, this.y);

  Point operator +(Point other) {
    return Point(x + other.x, y + other.y);
  }

  Point operator -(Point other) {
    return Point(x - other.x, y - other.y);
  }

  @override
  bool operator ==(Object other) {
    if (other is Point) {
      return x == other.x && y == other.y;
    } else {
      return false;
    }
  }

  @override
  int get hashCode => x.hashCode ^ y.hashCode;

  @override
  String toString() {
    return "($x, $y)";
  }
}


enum Direction {
  up(Point(0, -1)),
  down(Point(0, 1)),
  left(Point(-1, 0)),
  right(Point(1, 0));

  const Direction(this.point);

  final Point point;
}

class AStar {
  final int width;
  final int height;
  final List<List<int>> heightMap;

  AStar(this.width, this.height, this.heightMap)
      : assert(width > 0),
        assert(height > 0),
        assert(heightMap.length == height),
        assert(heightMap.every((e) => e.length == width));

  int heuristic(Point a, Point b) {
    return (a - b).x.abs() + (a - b).y.abs();
  }

  bool canMove(Point start, Point end) {
    assert(heuristic(start, end) == 1);
    return heightMap[start.y][start.x] + 1 >= heightMap[end.y][end.x];
  }

  List<List<Direction>>? findPath(Point start, Point end) {
    var open = <Point>[];
    var closed = <Point>[];
    var cameFrom = <Point, Point>{};
    var gScore = <Point, int>{};
    var fScore = <Point, int>{};
    open.add(start);
    gScore[start] = 0;
    fScore[start] = heuristic(start, end);
    while (open.isNotEmpty) {
      var current = open.reduce((a, b) => fScore[a]! < fScore[b]! ? a : b);
      // print("Processing $current");
      if (current == end) {
        // print("Found path");
        var path = <List<Direction>>[];
        while (current != start) {
          var previous = cameFrom[current]!;
          var direction = Direction.values.firstWhere((direction) {
            var target = previous + direction.point;
            return target == current;
          });
          path.add([direction]);
          current = previous;
        }
        return path.reversed.toList();
      }
      open.remove(current);
      closed.add(current);
      for (var direction in Direction.values) {
        var target = current + direction.point;
        // print("  Checking $target");
        if (target.x < 0 ||
            target.x >= width ||
            target.y < 0 ||
            target.y >= height) {
          // print("    Out of bounds");
          continue;
        }
        if (closed.contains(target)) {
          // print("    Already closed");
          continue;
        }
        if (!canMove(current, target)) {
          // print("    Can't move");
          continue;
        }
        var tentativeGScore = gScore[current]! + 1;
        if (!open.contains(target)) {
          // print("    Adding to open");
          open.add(target);
        } else if (tentativeGScore >= gScore[target]!) {
          // print("    Already better");
          continue;
        }
        cameFrom[target] = current;
        gScore[target] = tentativeGScore;
        fScore[target] = gScore[target]! + heuristic(target, end);
      }
    }
    return null;
  }
}

void main(List<String> arguments) {
  var content = File("bin/day12/input.txt").readAsStringSync().trim();
  var lines = content.split("\n");
  var width = lines[0].length;
  var height = lines.length;
  var heightMap = <List<int>>[];
  late Point start;
  late Point end;
  for (var line in lines) {
    var row = <int>[];
    for (var char in line.split("")) {
      final lowerA = "a".codeUnitAt(0);
      if (char == "S") {
        start = Point(row.length, heightMap.length);
        row.add(0);
      } else if (char == "E") {
        end = Point(row.length, heightMap.length);
        row.add("z".codeUnitAt(0) - lowerA);
      } else {
        row.add(char.codeUnitAt(0) - lowerA);
      }
    }
    heightMap.add(row);
  }
  var aStar = AStar(width, height, heightMap);
  var path = aStar.findPath(start, end);
  print(path?.length);
}
