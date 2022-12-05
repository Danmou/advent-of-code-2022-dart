import "dart:io";

const Map<String, String> myMoveMap = {
  "X": "A",  // rock
  "Y": "B",  // paper
  "Z": "C",  // scissors
};

const Map<String, int> moveScore = {
  "A": 1,  // rock
  "B": 2,  // paper
  "C": 3,  // scissors
};

void main(List<String> arguments) {
  var content = File("bin/day2/input.txt").readAsStringSync();
  var lines = content.trim().split("\n");
  var score = 0;
  for (var line in lines) {
    var parts = line.split(" ");
    var opponent = parts[0];
    var myMove = myMoveMap[parts[1]]!;
    score += moveScore[myMove]!;
    if (myMove == opponent) {
      // draw
      score += 3;
    } else if (myMove == "A" && opponent == "C" || myMove == "B" && opponent == "A" || myMove == "C" && opponent == "B") {
      // win
      score += 6;
    } else {
      // lose
    }
  }
  print(score);
}
