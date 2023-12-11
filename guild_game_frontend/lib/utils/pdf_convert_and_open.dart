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

Future<File> _writeToFile(Uint8List bytes, String filename) async {
  final directory = await getApplicationDocumentsDirectory();
  final file = File('${directory.path}/$filename');
  return file.writeAsBytes(bytes);
}

void _openPdf(File file) {
  OpenFile.open(file.path);
}

void convertAndOpenPdf(
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
