import 'dart:convert';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:guild_game_frontend/providers/quest_provider.dart';
import 'package:guild_game_frontend/widgets/modals/error_modal.dart';
import 'package:guild_game_frontend/widgets/modals/success_modal.dart';
import 'package:provider/provider.dart';

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

void uploadFile(
    BuildContext context, String walletAddress, String questId) async {
  try {
    final result = await _pickFile();
    _validateFileSize(result);

    if (result != null && result.files.isNotEmpty) {
      final base64String = await _convertToBase64(result.files.single);

      // Capture the provider before the async gap
      final questProvider = Provider.of<QuestProvider>(context, listen: false);

      // Continue after the async gap
      if (base64String != null) {
        // String walletAddress =
        //     '0x872...3dfv'; // Replace with actual wallet address
        // String questId = "123asd7a6sd7asd68"; // Replace with actual quest ID

        await questProvider.submitQuest(
            result.files.single.name, base64String, walletAddress, questId);

        // Optionally handle post-submission logic
        showSuccessDialog(context, "Your PDF Files was uploaded successfully!");
      }
    }
  } catch (e) {
    showErrorDialog(context, e.toString());
    print(e.toString());
  }
}
