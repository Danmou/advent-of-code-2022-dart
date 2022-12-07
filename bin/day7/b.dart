import "dart:io";

void main(List<String> arguments) {
  var content = File("bin/day7/input.txt").readAsStringSync().trim();
  var current_path = <String>[];
  var fileSizes = <String, int>{};
  var dirSizes = <String, int>{};
  var cdRegex = RegExp(r"^\$ cd (.+)$");
  var lsRegex = RegExp(r"^\$ ls$");
  var fileRegex = RegExp(r"^(\d+) (.+)$");
  var dirRegex = RegExp(r"^dir (.+)$");
  for (var line in content.split("\n")) {
    var cdMatch = cdRegex.firstMatch(line);
    if (cdMatch != null) {
      var dest = cdMatch.group(1)!;
      if (dest == "..") {
        current_path.removeLast();
      } else {
        current_path.add(dest);
      }
      continue;
    }
    var lsMatch = lsRegex.firstMatch(line);
    if (lsMatch != null) {
      continue;
    }
    var fileMatch = fileRegex.firstMatch(line);
    if (fileMatch != null) {
      var size = int.parse(fileMatch.group(1)!);
      var name = fileMatch.group(2)!;
      fileSizes["${current_path.join("/")}/$name"] = size;
      for (var i = 0; i < current_path.length; i++) {
        var path = current_path.sublist(0, i + 1).join("/");
        dirSizes[path] = (dirSizes[path] ?? 0) + size;
      }
      continue;
    }
    var dirMatch = dirRegex.firstMatch(line);
    if (dirMatch != null) {
      continue;
    }
    throw "Unrecognized line: $line";
  }

  const totalSpace = 70000000;
  const requiredSpace = 30000000;
  var freeSpace = totalSpace - dirSizes["/"]!;
  var spaceToFree = requiredSpace - freeSpace;

  var sizes = dirSizes.values.toList();
  sizes.sort();
  for (var size in sizes) {
    if (size >= spaceToFree) {
      print(size);
      return;
    }
  }
}
