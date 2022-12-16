import "dart:io";
import 'dart:math';


void main(List<String> arguments) {
  var content = File("bin/day13/input.txt").readAsStringSync().trim();
  var sections = content.split("\n\n");
  var pairs = sections.map((section) => section.split("\n")).toList();
  var correctlyOrdered = List.generate(pairs.length, (i) => i).where((i) => isCorrectlyOrdered(pairs[i][0], pairs[i][1])!).map((i) => i + 1).toList();
  print(correctlyOrdered.reduce((a, b) => a + b));
}

List<String> splitList(String input) {
  // Split "[[1, 2], [3, 4]]" into ["[1, 2]", "[3, 4]"]
  assert(input.startsWith("[") && input.endsWith("]"));
  var result = <String>[];
  var current = "";
  var depth = 0;
  for (var i = 1; i < input.length - 1; i++) {
    var c = input[i];
    if (c == "[") {
      depth++;
    } else if (c == "]") {
      depth--;
    }
    if (c == "," && depth == 0) {
      result.add(current);
      current = "";
    } else {
      current += c;
    }
  }
  if (current.isNotEmpty) {
    result.add(current);
  }
  return result;
}

bool? isCorrectlyOrdered(String left, String right) {
  print("Comparing $left and $right");
  dynamic leftValue;
  if (left.startsWith("[")) {
    leftValue = splitList(left);
  } else {
    leftValue = int.parse(left);
  }
  dynamic rightValue;
  if (right.startsWith("[")) {
    rightValue = splitList(right);
  } else {
    rightValue = int.parse(right);
  }
  if (leftValue is int) {
    if (rightValue is int) {
      return leftValue == rightValue ? null : leftValue < rightValue;
    } else {
      return isCorrectlyOrdered("[$left]", right);
    }
  } else {
    if (rightValue is int) {
      return isCorrectlyOrdered(left, "[$right]");
    } else {
      for (var i = 0; i < max(leftValue.length, rightValue.length); i++) {
        if (i >= leftValue.length) {
          return true;
        } else if (i >= rightValue.length) {
          return false;
        } else {
          var result = isCorrectlyOrdered(leftValue[i], rightValue[i]);
          if (result != null) {
            return result;
          }
        }
      }
      return null;
    }
  }
}
