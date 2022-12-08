import "dart:io";

void main(List<String> arguments) {
  var content = File("bin/day8/input.txt").readAsStringSync().trim();
  var heightGrid = content
      .split("\n")
      .map((e) => e.split("").map((e) => int.parse(e)).toList(growable: false))
      .toList(growable: false);
  var height = heightGrid.length;
  var width = heightGrid[0].length;
  var visibleGrid = List.generate(height,
      (index) => List.generate(width, (index) => false, growable: false),
      growable: false);
  // Check visibility from top to bottom.
  {
    var highestSoFar = List.generate(width, (index) => -1, growable: false);
    for (var row = 0; row < height; row++) {
      for (var col = 0; col < width; col++) {
        if (heightGrid[row][col] > highestSoFar[col]) {
          highestSoFar[col] = heightGrid[row][col];
          visibleGrid[row][col] = true;
        }
      }
    }
  }
  // Check visibility from bottom to top.
  {
    var highestSoFar = List.generate(width, (index) => -1, growable: false);
    for (var row = height - 1; row >= 0; row--) {
      for (var col = 0; col < width; col++) {
        if (heightGrid[row][col] > highestSoFar[col]) {
          highestSoFar[col] = heightGrid[row][col];
          visibleGrid[row][col] = true;
        }
      }
    }
  }
  // Check visibility from left to right.
  {
    var highestSoFar = List.generate(height, (index) => -1, growable: false);
    for (var col = 0; col < width; col++) {
      for (var row = 0; row < height; row++) {
        if (heightGrid[row][col] > highestSoFar[row]) {
          highestSoFar[row] = heightGrid[row][col];
          visibleGrid[row][col] = true;
        }
      }
    }
  }
  // Check visibility from right to left.
  {
    var highestSoFar = List.generate(height, (index) => -1, growable: false);
    for (var col = width - 1; col >= 0; col--) {
      for (var row = 0; row < height; row++) {
        if (heightGrid[row][col] > highestSoFar[row]) {
          highestSoFar[row] = heightGrid[row][col];
          visibleGrid[row][col] = true;
        }
      }
    }
  }

  var numVisible = visibleGrid
      .map((e) => e.where((e) => e).length)
      .reduce((value, element) => value + element);
  print(numVisible);
  print(visibleGrid.map((e) => e.map((e) => e ? "#" : ".").join()).join("\n"));
}
