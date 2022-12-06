import "dart:io";

void main(List<String> arguments) {
  var content = File("bin/day6/input.txt").readAsStringSync().trim();
  for (var i = 0; i < content.length - 14; i++) {
    var marker = content.substring(i, i + 14);
    if (marker.split("").toSet().length == 14) {
      print(i+14);
      return;
    }
  }
}
