import 'dart:convert';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

// This is for when Students want to upload a PDF file //

Future<FilePickerResult?> _pickFile() async {
  try {
    return await FilePicker.platform
        .pickFiles(type: FileType.custom, allowedExtensions: ['pdf']);
  } catch (e) {
    // Handle exception
    return null;
  }
}

void _validateFileSize(FilePickerResult? result) {
  if (result != null && result.files.single.size > 10000000) {
    // File is larger than 10MB
    throw 'File size exceeds 10MB';
  }
}

Future<String?> _convertToBase64(PlatformFile file) async {
  if (file.path != null) {
    final bytes = await File(file.path!).readAsBytes();
    return base64Encode(bytes);
  }
  return null;
}

Future<Map<String, String>?> uploadFile(
    BuildContext context, String walletAddress, String questId) async {
  try {
    final result = await _pickFile();
    _validateFileSize(result);

    if (result != null && result.files.isNotEmpty) {
      final base64String = await _convertToBase64(result.files.single);

      if (base64String != null) {
        return {
          "fileName": result.files.single.name,
          "base64String": base64String
        };
      }
    }
  } catch (e) {
    print("Error from: uploadFile, " + e.toString());
    Navigator.of(context).pop(); // Close the dialog

    rethrow;
  }
  return null;
}
