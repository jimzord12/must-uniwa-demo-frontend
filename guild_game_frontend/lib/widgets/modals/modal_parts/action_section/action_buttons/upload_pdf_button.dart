import 'package:flutter/material.dart';
import 'package:guild_game_frontend/widgets/modals/modal_parts/action_section/templates/action_section_button.dart';

class UploadPdfButton extends StatefulWidget {
  final VoidCallback onCreate;

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
    // final questProvider = Provider.of<QuestProvider>(context, listen: false);
    // final UserProvider userProvider =
    //     Provider.of<UserProvider>(context, listen: false);

    // void _uploadFile(
    //     BuildContext context, String walletAddress, String questId) async {
    //   try {
    //     final Map<String, String>? result =
    //         await uploadFile(context, walletAddress, questId);

    //     if (result == null) {
    //       throw Exception("Failed to upload file");
    //     }

    //     await questProvider.submitQuest(result['fileName']!,
    //         result['base64String']!, walletAddress, questId);

    //     await userProvider.fetchUserData(walletAddress);

    //     showSuccessDialog(context, "Your PDF Files was uploaded successfully!");
    //     // Simulating successful file upload
    //     setState(() {
    //       isButtonEnabled = false;
    //     });
    //   } catch (e) {
    //     // Handle the error
    //     showErrorDialog(context, e.toString());
    //   }
    // }

    return ActionSectionButton(
      text: isButtonEnabled ? "Sumbit PDF" : "PDF Uploaded!",
      icon: Icons.upload_file,
      backgroundColor: isButtonEnabled
          ? const Color.fromARGB(255, 187, 239, 242)
          : Colors.green,
      onPressed: isButtonEnabled
          ? () {
              widget.onCreate();
              setState(() {
                isButtonEnabled = false;
              });
            }
          : () {},
    );
  }
}
