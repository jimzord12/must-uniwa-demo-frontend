import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:guild_game_frontend/widgets/modals/error_modal.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';

Uint8List _base64ToBytes(String base64String) {
  return base64Decode(base64String);
}

// Future<File> _writeToFile(Uint8List bytes, String filename) async {
//   final directory = await getApplicationDocumentsDirectory();
//   print("THE PATH IS: ${directory.path}");
//   final file = File('${directory.path}/$filename');
//   return file.writeAsBytes(bytes);
// }

// Future<File> _writeToFile(Uint8List bytes, String filename) async {
//   final directory = await getExternalCacheDirectories();
//   final file = File('${directory!.first.path}/$filename');
//   return file.writeAsBytes(bytes);
// }

Future<File> _writeToFile(Uint8List bytes, String filename) async {
  if (Platform.isAndroid) {
    final directory = await getExternalCacheDirectories();
    final file = File('${directory!.first.path}/$filename');
    return file.writeAsBytes(bytes);
  } else if (Platform.isWindows) {
    final directory = Directory.current; // Use the current directory
    final file = File('${directory.path}/$filename');
    return file.writeAsBytes(bytes);
  } else {
    throw UnsupportedError('This platform is not supported');
  }
}

void _openPdf(File file) {
  OpenFile.open(file.path);
}

Future<void> convertAndOpenPdf(
    BuildContext context, String base64String, String filename) async {
  try {
    final bytes = _base64ToBytes(base64String);
    final file = await _writeToFile(bytes, filename);
    _openPdf(file);
  } catch (e) {
    // Handle the error
    showErrorDialog(context, e.toString());
  }
}
