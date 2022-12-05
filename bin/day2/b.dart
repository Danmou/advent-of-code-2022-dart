import "dart:io";

const Map<String, int> moveScore = {
  "A": 1,  // rock
  "B": 2,  // paper
  "C": 3,  // scissors
};

const Map<String, int> resultScore = {
  "X": 0,  // lose
  "Y": 3,  // draw
  "Z": 6,  // win
};

const Map<String, String> winningResponse = {
  "A": "B",  // rock->paper
  "B": "C",  // paper->scissors
  "C": "A",  // scissors->rock
};

const Map<String, String> losingResponse = {
  "A": "C",  // rock->scissors
  "B": "A",  // paper->rock
  "C": "B",  // scissors->paper
};

void main(List<String> arguments) {
  var content = File("bin/day2/input.txt").readAsStringSync();
  var lines = content.trim().split("\n");
  var score = 0;
  for (var line in lines) {
    var parts = line.split(" ");
    var opponentMove = parts[0];
    var result = parts[1];
    score += resultScore[result]!;
    if (result == "X") {
      // lose
      score += moveScore[losingResponse[opponentMove]]!;
    } else if (result == "Y") {
      // draw
      score += moveScore[opponentMove]!;
    } else {
      // win
      score += moveScore[winningResponse[opponentMove]]!;
    }
  }
  print(score);
}
