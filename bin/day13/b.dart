import "dart:io";
import 'dart:math';


void main(List<String> arguments) {
  var content = File("bin/day13/input.txt").readAsStringSync().trim();
  var sections = content.split("\n\n");
  var pairs = sections.map((section) => section.split("\n")).toList();
  var messages = pairs.expand((pair) => pair).toList();
  var dividers = ["[[2]]", "[[6]]"];
  messages += dividers;
  messages.sort((a, b) => isCorrectlyOrdered(a, b)! ? -1 : 1);
  print(dividers.map((divider) => messages.indexOf(divider) + 1).reduce((a, b) => a * b));
}

List<String> splitList(String input) {
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
