import 'dart:io';
import 'dart:math';
import 'dart:typed_data';
import 'package:path_provider/path_provider.dart';

class ImageFileManager {
  static Future<String> get localPath async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  static Future<File> saveImageWithBytes(Uint8List bytes) async {
    final path = await localPath;
    final imagePath = '$path/${randomString(20)}.png';

    File imageFile = File(imagePath);
    var savedFile = await imageFile.writeAsBytes(bytes);

    print(savedFile.path);

    return savedFile;
  }
}

String randomString(int length) {
  const _randomChars =
      "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789";
  const _charsLength = _randomChars.length;

  final rand = new Random();
  final codeUnits = new List.generate(
    length,
    (index) {
      final n = rand.nextInt(_charsLength);
      return _randomChars.codeUnitAt(n);
    },
  );
  return new String.fromCharCodes(codeUnits);
}
