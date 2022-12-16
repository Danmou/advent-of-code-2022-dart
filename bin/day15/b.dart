import "dart:io";

class Point {
  final int x;
  final int y;

  const Point(this.x, this.y);

  Point operator +(Point other) {
    return Point(x + other.x, y + other.y);
  }

  Point operator *(int other) {
    return Point(x * other, y * other);
  }

  int distanceTo(Point other) {
    return (x - other.x).abs() + (y - other.y).abs();
  }

  @override
  String toString() {
    return "($x, $y)";
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
}

void main(List<String> arguments) {
  var content = File("bin/day15/input.txt").readAsStringSync().trim();
  var sensorsAndRanges = <Point, int>{};
  var beacons = <Point>{};

  for (var line in content.split("\n")) {
    var parts = RegExp(
            r"Sensor at x=(-?\d+), y=(-?\d+): closest beacon is at x=(-?\d+), y=(-?\d+)")
        .firstMatch(line)!
        .groups([1, 2, 3, 4]);
    var sensor = Point(int.parse(parts[0]!), int.parse(parts[1]!));
    var closestBeacon = Point(int.parse(parts[2]!), int.parse(parts[3]!));
    sensorsAndRanges[sensor] = sensor.distanceTo(closestBeacon);
    beacons.add(closestBeacon);
  }

  const maxX = 4000000;
  const maxY = 4000000;
  var scale = 1000000;
  var candidates = List.generate((maxX ~/ scale) + 1,
          (x) => List.generate((maxY ~/ scale) + 1, (y) => Point(x, y)))
      .expand((e) => e)
      .where((p) => sensorsAndRanges.entries.every((e) {
            return e.key.distanceTo(p * scale) >= e.value - scale;
          }))
      .toList();

  while (scale > 1) {
    scale = scale ~/ 10;
    var newCandidates = <Point>[];
    for (var c in candidates) {
      for (var x = c.x * 10; x <= c.x * 10 + 10; x++) {
        for (var y = c.y * 10; y <= c.y * 10 + 10; y++) {
          if (x > maxX ~/ scale || y > maxY ~/ scale) {
            continue;
          }
          var p = Point(x, y);
          if (sensorsAndRanges.entries.every((e) {
            var maxDist = e.value;
            if (scale > 1) {
              maxDist -= scale * 2;
            }
            return e.key.distanceTo(p * scale) > maxDist;
          })) {
            newCandidates.add(p);
          }
        }
      }
    }
    candidates = newCandidates;
    print("scale: $scale, candidates: ${candidates.length}");
  }

  print(candidates[0].x * 4000000 + candidates[0].y);
}
