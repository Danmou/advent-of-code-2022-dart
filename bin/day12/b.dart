import "dart:io";
import "dart:math";


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

  const Direction(Point point) : point = point;

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

  List<List<int>> getDistanceFromAllPoints(Point end) {
    var distanceMap = List.generate(height, (_) => List.filled(width, -1));
    var queue = [end];
    distanceMap[end.y][end.x] = 0;
    while (queue.isNotEmpty) {
      var current = queue.removeAt(0);
      for (var direction in Direction.values) {
        var next = current + direction.point;
        if (next.x < 0 || next.x >= width || next.y < 0 || next.y >= height) {
          continue;
        }
        if (distanceMap[next.y][next.x] != -1) {
          continue;
        }
        if (!canMove(next, current)) {
          continue;
        }
        distanceMap[next.y][next.x] = distanceMap[current.y][current.x] + 1;
        queue.add(next);
      }
    }
    return distanceMap;
  }
}

void main(List<String> arguments) {
  var content = File("bin/day12/input.txt").readAsStringSync().trim();
  var lines = content.split("\n");
  var width = lines[0].length;
  var height = lines.length;
  var heightMap = <List<int>>[];
  var startOptions = <Point>[];
  late Point end;
  for (var line in lines) {
    var row = <int>[];
    for (var char in line.split("")) {
      final lowerA = "a".codeUnitAt(0);
      if (char == "S" || char == "a") {
        startOptions.add(Point(row.length, heightMap.length));
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
  var distanceMap = aStar.getDistanceFromAllPoints(end);
  var minDistance = startOptions
      .map((start) => distanceMap[start.y][start.x])
      .where((distance) => distance != -1)
      .reduce(min);
  print(minDistance);
}
