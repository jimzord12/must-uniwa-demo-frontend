import 'package:flutter/material.dart';
import 'package:guild_game_frontend/widgets/modals/modal_parts/action_section/templates/action_section_button.dart';

class UploadPdfButton extends StatefulWidget {
  final Future<bool> Function() onCreate;

  const UploadPdfButton({
    required this.onCreate,
    super.key,
  });

  @override
  UploadPdfButtonState createState() => UploadPdfButtonState();
}

class UploadPdfButtonState extends State<UploadPdfButton> {
  bool isButtonEnabled = true;

  @override
  Widget build(BuildContext context) {
    return ActionSectionButton(
      text: isButtonEnabled ? "Sumbit PDF" : "PDF Uploaded!",
      icon: Icons.upload_file,
      backgroundColor: isButtonEnabled
          ? const Color.fromARGB(255, 187, 239, 242)
          : Colors.green,
      onPressed: isButtonEnabled
          ? () async {
              bool wasSuccessful = await widget.onCreate();
              setState(() {
                isButtonEnabled = wasSuccessful;
              });
            }
          : () {},
    );
  }
}
