import "dart:io";

void main(List<String> arguments) {
  var content = File("bin/day6/input.txt").readAsStringSync().trim();
  for (var i = 0; i < content.length - 4; i++) {
    var marker = content.substring(i, i + 4);
    if (marker.split("").toSet().length == 4) {
      print(i+4);
      return;
    }
  }
}
