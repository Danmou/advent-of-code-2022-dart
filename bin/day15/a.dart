import "dart:io";
import 'dart:math';


class Point {
  final int x;
  final int y;

  const Point(this.x, this.y);

  Point operator +(Point other) {
    return Point(x + other.x, y + other.y);
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
  var sensorsAndClosestBeacon = <Point, Point>{};
  var beacons = <Point>{};

  const rowOfInterest = 2000000;
  var pointsWithNoBeacon = <int>{};

  for (var line in content.split("\n")) {
    var parts = RegExp(r"Sensor at x=(-?\d+), y=(-?\d+): closest beacon is at x=(-?\d+), y=(-?\d+)").firstMatch(line)!.groups([1, 2, 3, 4]);
    var sensor = Point(int.parse(parts[0]!), int.parse(parts[1]!));
    var closestBeacon = Point(int.parse(parts[2]!), int.parse(parts[3]!));
    sensorsAndClosestBeacon[sensor] = closestBeacon;
    beacons.add(closestBeacon);
    var sensorRange = sensor.distanceTo(closestBeacon) - (sensor.y - rowOfInterest).abs();
    for (var x = sensor.x - sensorRange; x <= sensor.x + sensorRange; x++) {
      pointsWithNoBeacon.add(x);
    }
  }

  for (var b in beacons) {
    if (b.y == rowOfInterest) {
      pointsWithNoBeacon.remove(b.x);
    }
  }
  print(pointsWithNoBeacon.length);
}
