import "dart:io";

void main(List<String> arguments) {
  var content = File("bin/day8/input.txt").readAsStringSync().trim();
  var heightGrid = content
      .split("\n")
      .map((e) => e.split("").map((e) => int.parse(e)).toList(growable: false))
      .toList(growable: false);
  var height = heightGrid.length;
  var width = heightGrid[0].length;

  var bestScenicScore = 0;
  for (var row = 1; row < height - 1; row++) {
    for (var col = 1; col < width - 1; col++) {
      var visibleUp = 0;
      for (var i = row - 1; i >= 0; i--) {
        visibleUp++;
        if (heightGrid[i][col] >= heightGrid[row][col]) {
          break;
        }
      }
      var visibleDown = 0;
      for (var i = row + 1; i < height; i++) {
        visibleDown++;
        if (heightGrid[i][col] >= heightGrid[row][col]) {
          break;
        }
      }
      var visibleLeft = 0;
      for (var i = col - 1; i >= 0; i--) {
        visibleLeft++;
        if (heightGrid[row][i] >= heightGrid[row][col]) {
          break;
        }
      }
      var visibleRight = 0;
      for (var i = col + 1; i < width; i++) {
        visibleRight++;
        if (heightGrid[row][i] >= heightGrid[row][col]) {
          break;
        }
      }
      var scenicScore = visibleUp * visibleDown * visibleLeft * visibleRight;
      if (scenicScore > bestScenicScore) {
        bestScenicScore = scenicScore;
      }
    }
  }

  print(bestScenicScore);
}
