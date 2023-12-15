import 'package:flutter/material.dart';
import 'package:guild_game_frontend/widgets/modals/modal_parts/action_section/templates/action_section_button.dart';

class DownloadPdfButton extends StatelessWidget {
  final VoidCallback onCreate;

  const DownloadPdfButton({
    super.key,
    required this.onCreate,
  });

  @override
  Widget build(BuildContext context) {
    // final questProvider = Provider.of<QuestProvider>(context, listen: false);

    // void downloadFile(BuildContext context) async {
    //   // final pdfName = questProvider.currentQuest!.pdfFilename!;
    //   final pdfBase64content = await questProvider.fetchPdfContent(pdfName);
    //   await convertAndOpenPdf(context, pdfBase64content, pdfName);
    // }

    return ActionSectionButton(
      text: "Download PDF",
      icon: Icons.download,
      backgroundColor: const Color.fromARGB(255, 187, 239, 242),
      onPressed: onCreate,
    );
  }
}
