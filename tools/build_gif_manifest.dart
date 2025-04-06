import 'dart:convert';
import 'dart:io';

void main() async {
  final dir = Directory('assets/gifs');
  if (!await dir.exists()) {
    print('Error: assets/gifs folder does not exist');
    exit(1);
  }

  final gifFiles =
      dir
          .listSync()
          .whereType<File>()
          .where((file) => file.path.endsWith('.gif'))
          .map((file) => file.path.replaceAll('\\', '/')) // Windows compatibility
          .toList();

  final output = File('assets/gifs/gifs.json');
  await output.writeAsString(jsonEncode(gifFiles));
  print('Generated ${gifFiles.length} entries to assets/gifs/gifs.json');
}
