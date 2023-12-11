import 'package:flutter/material.dart';
import 'package:guild_game_frontend/utils/pdf_picker.dart';
import 'package:guild_game_frontend/widgets/modals/error_modal.dart';
import 'package:guild_game_frontend/widgets/modals/modal_parts/action_section/templates/action_section_button.dart';
import 'package:guild_game_frontend/widgets/modals/success_modal.dart';

class UploadPdfButton extends StatefulWidget {
  final String walletAddress;
  final String questId;

  const UploadPdfButton({
    super.key,
    required this.walletAddress,
    required this.questId,
  });

  @override
  _UploadPdfButtonState createState() => _UploadPdfButtonState();
}

class _UploadPdfButtonState extends State<UploadPdfButton> {
  bool isButtonEnabled = true;

  void _uploadFile(
      BuildContext context, String walletAddress, String questId) async {
    try {
      // TODO: Implement file upload logic here
      await uploadFile(context, walletAddress, questId);
      showSuccessDialog(context, "Your PDF Files was uploaded successfully!");
      // Simulating successful file upload
      setState(() {
        isButtonEnabled = false;
      });
    } catch (e) {
      // Handle the error
      showErrorDialog(context, e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return ActionSectionButton(
      text: isButtonEnabled ? "Sumbit PDF" : "PDF Uploaded!",
      icon: Icons.upload_file,
      backgroundColor: isButtonEnabled
          ? const Color.fromARGB(255, 187, 239, 242)
          : Colors.green,
      onPressed: isButtonEnabled
          ? () => _uploadFile(context, widget.walletAddress, widget.questId)
          : () {},
    );
  }
}
