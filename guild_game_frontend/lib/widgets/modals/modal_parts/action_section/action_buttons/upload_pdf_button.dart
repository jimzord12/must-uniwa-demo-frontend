import 'package:flutter/material.dart';
import 'package:guild_game_frontend/utils/pdf_picker.dart';
import 'package:guild_game_frontend/widgets/modals/modal_parts/action_section/templates/action_section_button.dart';

class UploadPdfButton extends StatefulWidget {
  final String walletAddress;
  final String questId;

  UploadPdfButton({
    Key? key,
    required this.walletAddress,
    required this.questId,
  }) : super(key: key);

  @override
  _UploadPdfButtonState createState() => _UploadPdfButtonState();
}

class _UploadPdfButtonState extends State<UploadPdfButton> {
  bool isButtonEnabled = true;

  void _uploadFile(
      BuildContext context, String walletAddress, String questId) async {
    // TODO: Implement file upload logic here
    uploadFile(context, walletAddress, questId);
    // Simulating successful file upload
    setState(() {
      isButtonEnabled = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return ActionSectionButton(
      text: isButtonEnabled ? "Upload PDF" : "PDF Uploaded!",
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
